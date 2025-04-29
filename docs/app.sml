App {
    name: "MyApp"
    icon: "icon.png"
    id: "at.crowdware.freebookreader"
    smlVersion: "1.1"

    RestDatasource {
        id: "books"
        url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&limit=50&order=date&locale=string:lang"
        mock: "books.json"
    }

    Theme {
        primary: "#FF0C8CE9"
        onPrimary: "#FFFFFF"
        primaryContainer: "#FFDDB3"
        onPrimaryContainer: "#291800"
        secondary: "#6F5B40"
        onSecondary: "#FFFFFF"
        secondaryContainer: "#FBDEBC"
        onSecondaryContainer: "#271904"
        tertiary: "#51643F"
        onTertiary: "#FFFFFF"
        tertiaryContainer: "#D4EABB"
        onTertiaryContainer: "#102004"
        error: "#BA1A1A"
        errorContainer: "#FFDAD6"
        onError: "#FFFFFF"
        onErrorContainer: "#410002"
        background: "#FFFBFF"
        onBackground: "#1F1B16"
        surface: "#FFFBFF"
        onSurface: "#1F1B16"
        surfaceVariant: "#F0E0CF"
        onSurfaceVariant: "#4F4539"
        outline: "#817567"
        inverseOnSurface: "#F9EFE7"
        inverseSurface: "#34302A"
        inversePrimary: "#FFB951"
        surfaceTint: "#825500"
        utlineVariant: "#D3C4B4"
        scrim: "#000000"
    }


// deployment start - don't edit here
    Deployment {
        File { path: "about.sml" time: "2025.04.29 21.18.52" type: "page" }
        File { path: "books.sml" time: "2025.04.29 19.55.48" type: "page" }
        File { path: "home.sml" time: "2025.04.29 22.18.29" type: "page" }
        File { path: "part1-pt.md" time: "2025.04.29 19.59.41" type: "part" }
        File { path: "part3-pt.md" time: "2025.04.29 20.01.30" type: "part" }
        File { path: "part2-pt.md" time: "2025.04.29 20.00.54" type: "part" }
        File { path: "part2-en.md" time: "2025.04.29 19.54.01" type: "part" }
        File { path: "part2-fr.md" time: "2025.04.29 22.06.45" type: "part" }
        File { path: "part3-de.md" time: "2025.04.29 19.52.33" type: "part" }
        File { path: "part2-es.md" time: "2025.04.29 20.10.51" type: "part" }
        File { path: "part2-eo.md" time: "2025.04.29 20.14.51" type: "part" }
        File { path: "part1-de.md" time: "2025.04.29 19.49.49" type: "part" }
        File { path: "part1-fr.md" time: "2025.04.29 22.06.07" type: "part" }
        File { path: "part1-en.md" time: "2025.04.29 19.53.27" type: "part" }
        File { path: "part3-en.md" time: "2025.04.29 19.54.33" type: "part" }
        File { path: "part3-fr.md" time: "2025.04.29 22.07.11" type: "part" }
        File { path: "part1-es.md" time: "2025.04.29 20.10.10" type: "part" }
        File { path: "part3-eo.md" time: "2025.04.29 20.15.17" type: "part" }
        File { path: "part3-es.md" time: "2025.04.29 20.11.09" type: "part" }
        File { path: "part2-de.md" time: "2025.04.29 20.00.44" type: "part" }
        File { path: "part1-eo.md" time: "2025.04.29 20.14.24" type: "part" }
        File { path: "plus.png" time: "2025.04.11 08.13.25" type: "image" }
        File { path: "desktop.png" time: "2024.10.14 09.37.53" type: "image" }
        File { path: "ship.png" time: "2024.09.03 09.08.18" type: "image" }
        File { path: "herz.png" time: "2025.04.11 07.13.31" type: "image" }
        File { path: "menu.png" time: "2024.10.16 05.50.12" type: "image" }
        File { path: "art_anyona.jpg" time: "2024.10.15 00.52.04" type: "image" }
        File { path: "herz_outline.png" time: "2025.04.11 07.13.51" type: "image" }
        File { path: "olaf.jpg" time: "2023.06.11 04.47.15" type: "image" }
        File { path: "Strings-pt.sml" time: "2025.04.29 22.25.13" type: "translation" }
        File { path: "Strings-de.sml" time: "2025.04.29 22.24.35" type: "translation" }
        File { path: "Strings-es.sml" time: "2025.04.29 22.25.00" type: "translation" }
        File { path: "Strings-fr.sml" time: "2025.04.29 22.25.07" type: "translation" }
        File { path: "Strings-eo.sml" time: "2025.04.29 22.24.54" type: "translation" }
        File { path: "Strings-en.sml" time: "2025.04.29 22.24.45" type: "translation" }

    }
// deployment end
}