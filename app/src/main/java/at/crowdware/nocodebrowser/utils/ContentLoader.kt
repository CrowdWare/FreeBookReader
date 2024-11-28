/****************************************************************************
 * Copyright (C) 2024 CrowdWare
 *
 * This file is part of FreeBookBrowser.
 *
 *  FreeBookBrowser is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  FreeBookBrowser is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with FreeBookBrowser.  If not, see <http://www.gnu.org/licenses/>.
 *
 ****************************************************************************/
package at.crowdware.freebookreader.utils
import android.os.Build
import androidx.annotation.RequiresApi
import at.crowdware.freebookreader.MainActivity
import at.crowdware.freebookreader.logic.LocaleManager
import at.crowdware.freebookreader.logic.PersistanceManager
import at.crowdware.freebookreader.parseApp
import at.crowdware.freebookreader.parsePage
import at.crowdware.freebookreader.ui.App
import at.crowdware.freebookreader.ui.Page
import kotlinx.coroutines.*
import okhttp3.*
import java.io.File
import java.io.IOException
import java.time.Instant
import java.time.LocalDateTime
import java.time.ZoneId

data class Link(val titel: String, val url: String)

class ContentLoader {
    private lateinit var okHttpClient: OkHttpClient
    private lateinit var context: MainActivity
    var app: App? = null
    lateinit var appUrl: String
    private var appLoaded = false
    val links: MutableList<Link> = mutableListOf()

    // Initialize the OkHttp client and setup cache directory
    fun init(ctx: MainActivity) {
        context = ctx
        okHttpClient = OkHttpClient.Builder().build()

        val directory = File(ctx.filesDir, "ContentCache")
        if (!directory.exists()) {
            directory.mkdir()
        }

        // load link list
        val file = File(context.filesDir, "links.txt")
        if(file.exists()) {
            val list = file.readLines()
            for (line in list) {
                val values = line.split("|")
                links.add(Link(values[0], values[1]))
            }
        }
    }

    fun addLink(title: String, url: String) {
        val file = File(context.filesDir, "links.txt")
        if (!file.exists()) {
            file.createNewFile()
        }
        file.appendText("$title|$url\n")
    }

    fun removeLink(title: String, url: String) {
        links.removeIf { it.titel == title && it.url == url }
        val file = File(context.filesDir, "links.txt")
        file.delete()
        file.createNewFile()
        for(link in links) {
            file.writeText("${link.titel}|${link.url}\n")
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    suspend fun loadAsset(name: String, subdir: String): String {
        var fileContent: ByteArray? = null
        val url = "$appUrl/$subdir/$name"
        if(app == null) {
            return ""
        }
        val result = app!!.deployment.files.find { it.path == "$name" }
        if (result == null) {
            return ""
        }
        val fileName = ("ContentCache/" + appUrl.substringAfter("://") + "/$subdir/").replace(".", "_").replace(":", "_") + "$name"
        val file = File(context.filesDir, fileName)
        var ret = true
        if (file.exists()) {
            val lastModifiedMillis = file.lastModified()
            val lastModifiedDateTime = LocalDateTime.ofInstant(Instant.ofEpochMilli(lastModifiedMillis), ZoneId.systemDefault())
            if (result.time.isAfter(lastModifiedDateTime)) {
                // web server version is newer
                ret = loadAndCacheAsset(url, fileName, result.time)
            }
        } else {
            ret = loadAndCacheAsset(url, fileName, result.time)
        }
        return if (ret)
            fileName
        else
            ""
    }

    @RequiresApi(Build.VERSION_CODES.O)
    suspend fun switchApp(url: String) {
        if(url != appUrl) {
            val app = loadApp(url+ "/app.sml")
            if(app != null) {
                context.setNewApp(app)
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    suspend fun loadPage(name: String): Page? {
        var lang = "-" + LocaleManager.getLanguage()

        if (appUrl != MainActivity.url.substringBefore("/app.sml"))
            lang = "" // only one language for books, for now
        var fileContent = ""
        val url = "$appUrl/pages$lang/$name.sml"
        if (app == null)
            return null
        val result = app!!.deployment.files.find { it.path == "$name.sml"}
        if (result == null) {
            return null
        }
        val fileName = ("ContentCache/" + appUrl.substringAfter("://") + "/pages$lang/$name").replace(".", "_").replace(":", "_") + ".sml"
        val file = File(context.filesDir, fileName)
        fileContent = if (file.exists()) {
            val lastModifiedMillis = file.lastModified()
            val lastModifiedDateTime = LocalDateTime.ofInstant(Instant.ofEpochMilli(lastModifiedMillis), ZoneId.systemDefault())
            if (result.time.isAfter(lastModifiedDateTime)) {
                // web server version is newer
                loadAndCacheSml(url, fileName, result.time) ?: ""
            } else {
                // use cache version instead
                file.readText()
            }
        } else {
            loadAndCacheSml(url, fileName, result.time) ?: ""
        }
        var page = parsePage(fileContent)
        if (page == null) {
            page = parsePage("Page { Column { padding: \"16\" Text { color: \"#FF0000\" fontSize: 18 text:\"An error occurred loading the home page.\"}}}")
        }
        return page
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private suspend fun loadAndCacheSml(url: String, fileName: String, time: LocalDateTime): String? {
        val sml = withContext(Dispatchers.IO) {
            downloadSml(url)
        }
        if (sml != null) {
            val cache = File(context.filesDir, fileName)
            // Make sure the parent directories exist
            val parentDir = cache.parentFile
            if (parentDir != null && !parentDir.exists()) {
                parentDir.mkdirs()
            }
            cache.writeText(sml)
            val millis = time
                .atZone(ZoneId.systemDefault()) // Convert to ZonedDateTime in the system's default time zone
                .toInstant() // Convert to Instant (which represents a moment in time)
                .toEpochMilli()
            cache.setLastModified(millis)
        }
        return sml
    }

    // Suspend function to load the app asynchronously
    @RequiresApi(Build.VERSION_CODES.O)
    suspend fun loadApp(url: String): App? = withContext(Dispatchers.IO) {
        var fileContent = ""

        appUrl = url.substringBefore("/app.sml")

        val fileName = "ContentCache/" + appUrl.substringAfter("://").replace(".", "_").replace(":", "_") + "/app.sml"
        val file = File(context.filesDir, fileName)

        // Make sure the parent directories exist
        val parentDir = file.parentFile
        if (parentDir != null && !parentDir.exists()) {
            parentDir.mkdirs()
        }

        // load last saved version in case webserver is offline
        if (file.exists()) {
            fileContent = file.readText()
        }

        if(fileContent.contains("precached")) {
            app = parseApp(fileContent)
            appLoaded = true
        } else {
            // Download content from the URL
            var appContent = downloadSml(url)
            if (appContent != null) {
                if (fileContent != appContent) {
                    // Write new content to the cache if it has changed, in case web server is offline
                    file.writeText(appContent)
                }
            } else {
                // Use cached content if available
                if (fileContent.isNotEmpty()) {
                    appContent = fileContent
                }
            }

            // Parse the app content
            if (appContent != null && appContent.isNotEmpty()) {
                app = parseApp(appContent)
                appLoaded = true
            }
        }
        return@withContext app
    }

    // Suspend function to download content asynchronously
    suspend fun downloadSml(url: String): String? = withContext(Dispatchers.IO) {
        val request = Request.Builder().url(url).build()
        return@withContext try {
            // Use OkHttp's enqueue for asynchronous call
            val response = okHttpClient.newCall(request).await()
            if (response.isSuccessful) {
                response.body?.string()
            } else {
                null
            }
        } catch (e: IOException) {
            e.printStackTrace()
            null
        }
    }

    suspend fun downloadAsset(url: String): ByteArray? = withContext(Dispatchers.IO) {
        val request = Request.Builder().url(url).build()
        return@withContext try {
            val response = okHttpClient.newCall(request).await()
            if (response.isSuccessful) {
                // Read the response body as a ByteArray
                response.body?.byteStream()?.use { inputStream ->
                    inputStream.readBytes()
                }
            } else {
                null
            }
        } catch (e: IOException) {
            e.printStackTrace()
            null
        }
    }

    // Extension function to convert OkHttp Call into a suspending function
    private suspend fun Call.await(): Response = suspendCancellableCoroutine { continuation ->
        enqueue(object : Callback {
            override fun onFailure(call: Call, e: IOException) {
                if (continuation.isCancelled) return
                continuation.resumeWith(Result.failure(e))
            }

            override fun onResponse(call: Call, response: Response) {
                if (continuation.isCancelled) return
                continuation.resumeWith(Result.success(response))
            }
        })

        continuation.invokeOnCancellation {
            try {
                cancel()
            } catch (ex: Throwable) {
                // Handle cancellation exception
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    suspend fun loadAndCacheAsset(url: String, fileName: String, time: LocalDateTime): Boolean {
        val bytes = withContext(Dispatchers.IO) {
            downloadAsset(url)
        }
        if (bytes != null) {
            val cache = File(context.filesDir, fileName)
            val parentDir = cache.parentFile
            if (parentDir != null && !parentDir.exists()) {
                parentDir.mkdirs()
            }
            cache.writeBytes(bytes)
            val millis = time
                .atZone(ZoneId.systemDefault())
                .toInstant()
                .toEpochMilli()
            cache.setLastModified(millis)
        }
        return true
    }
}