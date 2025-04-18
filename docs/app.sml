App {
    name: "MyApp"
    icon: "icon.png"
    id: "at.crowdware.freebookreader"
    smlVersion: "1.1"

    RestDatasource {
        id: "books"
        url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&limit=50&order=date"
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
        File { path: "about.sml" time: "2025.04.18 17.06.12" type: "page-en" }
        File { path: "books.sml" time: "2025.04.18 17.08.19" type: "page-en" }
        File { path: "home.sml" time: "2025.04.18 17.11.01" type: "page-en" }
        File { path: "about.sml" time: "2025.04.18 17.06.01" type: "page-de" }
        File { path: "books.sml" time: "2025.04.12 12.07.18" type: "page-de" }
        File { path: "home.sml" time: "2025.04.12 12.03.04" type: "page-de" }
        File { path: "about.sml" time: "2025.04.18 17.06.41" type: "page-es" }
        File { path: "books.sml" time: "2025.04.18 17.08.44" type: "page-es" }
        File { path: "home.sml" time: "2025.04.18 17.11.24" type: "page-es" }
        File { path: "about.sml" time: "2025.04.18 17.07.12" type: "page-pt" }
        File { path: "books.sml" time: "2025.04.18 17.09.05" type: "page-pt" }
        File { path: "home.sml" time: "2025.04.18 17.11.42" type: "page-pt" }
        File { path: "about.sml" time: "2025.04.18 17.06.56" type: "page-fr" }
        File { path: "books.sml" time: "2025.04.18 17.08.53" type: "page-fr" }
        File { path: "home.sml" time: "2025.04.18 17.11.34" type: "page-fr" }
        File { path: "about.sml" time: "2025.04.18 17.06.29" type: "page-eo" }
        File { path: "books.sml" time: "2025.04.18 17.08.31" type: "page-eo" }
        File { path: "home.sml" time: "2025.04.18 17.11.14" type: "page-eo" }
        File { path: "plus.png" time: "2025.04.11 08.13.25" type: "image" }
        File { path: "desktop.png" time: "2024.10.14 09.37.53" type: "image" }
        File { path: "ship.png" time: "2024.09.03 09.08.18" type: "image" }
        File { path: "herz.png" time: "2025.04.11 07.13.31" type: "image" }
        File { path: "menu.png" time: "2024.10.16 05.50.12" type: "image" }
        File { path: "art_anyona.jpg" time: "2024.10.15 00.52.04" type: "image" }
        File { path: "herz_outline.png" time: "2025.04.11 07.13.51" type: "image" }
        File { path: "olaf.jpg" time: "2023.06.11 04.47.15" type: "image" }

    }
// deployment end
}