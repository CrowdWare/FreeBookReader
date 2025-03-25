Page {
    padding: "8"
    title: "NoCodeLibMobile"

    Column {
        padding: "8"
                        
        Markdown {
            color: "#4C9BD9"
            text: "# Favoritos"
        }
        
        LazyRow {
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&locale=es&filter=inList:favourite[uuid]"
            height: 220

            LazyContent {
                Column { 
                    weight:1
                    
                    AsyncImage { 
                        src: "<pictureurl>" 
                        width: 120
                        link: "<url>"
                    }
                    //Button {label: "REM" link: "remove:favourite[<uuid>]"}
                }
                
                Spacer {amount: 8}
            }

            LazyNoContent {
                Markdown { text: "## Aún no has añadido ningún libro a tus favoritos..."}
            }
        }  
        
        Spacer {amount: 16}
        Markdown {
            color: "#4C9BD9"
            text: "# Novedades"
          }
        LazyRow {
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&locale=es&limit=13&filter=notInList:favourite[uuid]"
            height: 220

            LazyContent {
                Column { 
                    weight:1
                    
                    AsyncImage { 
                        src: "<pictureurl>" 
                        width: 120
                        link: "<url>"
                    }
                }
                Spacer {amount: 8}
            }
        }  
        Spacer { weight: 1 }
        Button { label: "Buscar Libros" link: "page:app.books" }
    }
}