Page {
    padding: "8"
    title: "NoCodeLibMobile"

    Column {
        padding: "8"
                        
        Markdown {
            color: "#4C9BD9"
            text: "# Favoriten"
        }
        
        LazyRow {
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&locale=de&filter=inList:favourite[uuid]"
            height: 220

            LazyContent {
                Column { 
                    weight:1
                    Box {
                        width: 120

                        AsyncImage{
                            src: "<pictureurl>" 
                            width: 120 
                            link: "<url>"
                        }
                        Image{src: "herz.png" width: 32 height: 32 
                            align: "topEnd"
                            link: "remove:favourite[<uuid>]"}
                    }
                }
                Spacer {amount: 8}
            }

            LazyNoContent {
                Markdown { text: "## Sie haben noch kein Buch zu ihren Favoriten gemacht..."}
            }
        }  
        
        Spacer {amount: 16}
        Markdown {
            color: "#4C9BD9"
            text: "# Neuerscheinungen"
          }
        LazyRow {
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&locale=de&limit=13&filter=notInList:favourite[uuid]"
            height: 220

            LazyContent {
                Column { 
                    weight:1
                    
                      Box {
                        width: 120
                        
                        AsyncImage{
                            src: "<pictureurl>" 
                            width: 120 
                            link: "<url>"
                        }

                        Image{src: "herz_outline.png" width: 32 height: 32 
                            align: "topEnd"
                            link: "add:favourite[<uuid>]"}
                    }
                }
                Spacer {amount: 8}
            }
        }  
        
        Spacer { weight: 1 }
        Button { label: "Bücher Finden" link: "page:app.books" }
    }
}