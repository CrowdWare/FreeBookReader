/****************************************************************************
 * Copyright (C) 2024 CrowdWare
 *
 * This file is part of FreeBookReader.
 *
 *  FreeBookReader is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  FreeBookReader is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with FreeBookReader.  If not, see <http://www.gnu.org/licenses/>.
 *
 ****************************************************************************/
package at.crowdware.freebookreader

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.view.View
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.annotation.RequiresApi
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.systemBarsPadding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AccountCircle
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material.icons.filled.ShoppingCart
import androidx.compose.material.icons.filled.Star
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.stringResource
import androidx.lifecycle.lifecycleScope
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import at.crowdware.freebookreader.logic.LocaleManager
import at.crowdware.freebookreader.ui.App
import at.crowdware.freebookreader.ui.theme.FreeBookReaderTheme
import at.crowdware.freebookreader.ui.widgets.NavigationItem
import at.crowdware.freebookreader.ui.widgets.NavigationView
import at.crowdware.freebookreader.utils.ContentLoader
import at.crowdware.freebookreader.view.LoadPage
import com.google.android.filament.utils.Utils
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.io.File
import java.nio.ByteBuffer

@SuppressLint("UnusedMaterial3ScaffoldPaddingParameter")
class MainActivity : ComponentActivity() {
    val contentLoader = ContentLoader()
    private var app: App? by mutableStateOf(null)
    private var loading by mutableStateOf(false)
    var cameraDistance: Float = 0F

    companion object {
        init { Utils.init() }

        const val url = "https://crowdware.github.io/FreeBookReader/app.sml"
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val context = this
        window.decorView.systemUiVisibility = (
                View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                        or View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
                )
        installCacheFromAssets()

        contentLoader.init(this)
        lifecycleScope.launch(Dispatchers.Main) {
            // load the dynamic app, we can change the content on the web server
            if (!loading) {
                loading = true
                app = contentLoader.loadApp(Companion.url)
            }
            if (app != null) {
                enableEdgeToEdge()
                setContent {
                    FreeBookReaderTheme(app!!.theme) {
                        LocaleManager.init(applicationContext, resources)

                        if(app!!.id == "at.crowdware.freebookreader") {
                            // in the local app we use Scaffold and the navigation drawer
                            Scaffold(modifier = Modifier.fillMaxSize()) { _ ->
                                val list = mutableListOf(
                                    NavigationItem(
                                        "app.home",
                                        contentLoader.appUrl,
                                        Icons.Default.Home,
                                        stringResource(R.string.navigation_home)
                                    ),
                                    NavigationItem(
                                        "app.books",
                                        contentLoader.appUrl,
                                        Icons.Default.ShoppingCart,
                                        stringResource(R.string.navigation_books)
                                    ),
                                    NavigationItem(
                                        "app.about",
                                        contentLoader.appUrl,
                                        Icons.Default.AccountCircle,
                                        stringResource(R.string.navigation_about)
                                    ),
                                    NavigationItem(
                                        "app.settings",
                                        "",
                                        Icons.Default.Settings,
                                        stringResource(R.string.settings)
                                    ),
                                )
                                if (contentLoader.links.isNotEmpty())
                                    list.add(NavigationItem("divider"))
                                for (link in contentLoader.links) {
                                    list.add(
                                        NavigationItem(
                                            "home",
                                            link.url,
                                            Icons.Default.Star,
                                            link.titel
                                        )
                                    )
                                }

                                // navigation targets which are not listed in the drawer
                                for (file in app!!.deployment.files) {
                                    if (file.path.endsWith(".sml")) {
                                        list.add(
                                            NavigationItem(
                                                file.path.substringBefore(".sml"),
                                                contentLoader.appUrl,
                                            )
                                        )
                                    }
                                }
                                NavigationView(list, context)
                            }
                        } else {
                            // if the external app is loaded we only render the app
                            val navController = rememberNavController()
                            val color = remember { mutableStateOf(Color.Unspecified) }
                            val list = mutableListOf<String>()

                            // navigation targets which are not listed in the drawer
                            for (file in app!!.deployment.files) {
                                if (file.path.endsWith(".sml")) {
                                    list.add(file.path.substringBefore(".sml"))
                                }
                            }
                            Scaffold(modifier = Modifier.fillMaxSize(),
                            ) {
                                if (list.isNotEmpty()) {
                                    NavHost(
                                        navController = navController,
                                        startDestination = "home",
                                        modifier = Modifier
                                            .background(color = color.value)
                                            .systemBarsPadding()
                                    ) {
                                        for (index in list.indices) {
                                            composable(list[index]) {
                                                LoadPage(
                                                    list[index],
                                                    color,
                                                    context,
                                                    navController
                                                )
                                            }
                                        }
                                    }
                                } else {
                                    Text("The list of pages is empty. Maybe the deployment descriptor list has not been added to app.sml.")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private fun readAsset(assetName: String): ByteBuffer {
        val input = assets.open(assetName)
        val bytes = ByteArray(input.available())
        input.read(bytes)
        return ByteBuffer.wrap(bytes)
    }

    fun setNewApp(ap: App) {
        app = ap
    }

    fun openWebPage( url: String) {
        val browserIntent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
        startActivity(browserIntent)
    }

    fun sendToAnimation(cmd: String) {
        // TODO
        if (cmd == "zoomin") {
            cameraDistance += 1.0F
            //zoomCamera(cameraDistance)
        }
        else if(cmd == "zoomout") {
            cameraDistance -= 1.0F
            //zoomCamera(cameraDistance)
        }
    }

    override fun attachBaseContext(newBase: Context?) {
        super.attachBaseContext(LocaleManager.wrapContext(newBase!!))
    }

    // this technique is used to pre install the app to the cache for faster loads
    private fun installCacheFromAssets() {
        val directory = File(this.filesDir, "ContentCache/crowdware_github_io/FreeBookReader")
        var pages: File
        var parts: File
        var images: File
        var sounds: File
        var videos: File
        var models: File
        var textures: File

        if (directory.exists()) {
            return // files exists, nothing to do
        } else {
            try {
                this.assets.open("FreeBookReader/app.sml")
            } catch(e: Exception) {
                return // no pre cached data found, so we have to load via internet
            }
            directory.mkdirs()
            images = File(directory, "images")
            images.mkdir()
            sounds = File(directory, "sounds")
            sounds.mkdir()
            videos = File(directory, "videos")
            videos.mkdir()
            pages = File(directory, "pages")
            pages.mkdir()
            parts = File(directory, "parts")
            parts.mkdir()
            models = File(directory, "models")
            models.mkdir()
            textures = File(directory, "textures")
            textures.mkdir()
        }

        try {
            copyDir("images", images)
            copyDir("sounds", sounds)
            copyDir("videos", videos)
            copyDir("pages", pages)
            copyDir("parts", pages)
            copyDir("models", pages)
            copyDir("textures", pages)
            copyDir("", directory)
        } catch(e: Exception) {
            println("Error in installCacheFromAssets: ${e.message}")
        }
    }

    private fun copyDir(source: String, directory: File) {
        val files = this.assets.list(source)
        if (files != null) {
            for (file in files) {
                if (source == "")
                    copyFile("$file", file, directory)
                else
                    copyFile("$source/$file", file, directory)
            }
        }
    }

    private fun copyFile(source: String, target: String, directory: File) {
        val inputStream = this.assets.open(source)
        val outFile = File(directory, target)
        inputStream.use { input ->
            outFile.outputStream().use { output ->
                input.copyTo(output)
            }
        }
    }
}

