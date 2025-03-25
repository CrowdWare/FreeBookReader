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
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&locale=pt&filter=inList:favourite[uuid]"
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
                Markdown { text: "## Você ainda não adicionou nenhum livro aos seus favoritos..."}
            }
        }  
        
        Spacer {amount: 16}
        Markdown {
            color: "#4C9BD9"
            text: "# Novidades"
          }
        LazyRow {
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&locale=pt&limit=13&filter=notInList:favourite[uuid]"
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
        Button { label: "Encontrar Livros" link: "page:app.books" }
    }
}