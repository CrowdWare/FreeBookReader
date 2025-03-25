Page {
    padding: "8"
    title: "NoCodeLibMobile"
   

    Column {
        padding: "8"
                        
        Markdown {
            color: "#4C9BD9"
            text: "# Buscar Libros"
        }
        Markdown {
            text: "Aquí encontrarás una lista de todos los libros publicados."
        }
        Spacer {amount: 8}


        LazyColumn {
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&locale=es" 
            weight: 1

            LazyContent {
                Row {
                    padding: "8"
              
                        AsyncImage { 
                            src: "<pictureurl>" 
                            width: 50
                            weight: 1
                            link: "<url>"
                        }
                        
                    
                    Spacer {amount: 8}
                    Markdown {
                        weight: 1
                        text: "<description>"
                    }
                    Spacer {amount: 8}
                }
                //Button {label: "FAV" link: "add:favourite[<uuid>]"}
            }
        }

        Spacer {amount: 8}
        Button {label: "Home" link: "page:app.home" }
    }
}