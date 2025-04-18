Page {
    padding: "8"
    title: "NoCodeLibMobile"

    Column {
        padding: "8"
                        
        Markdown {
            color: "#4C9BD9"
            text: "# Favoratoj"
        }
        
        LazyRow {
            padding: "8"
            datasource: "books"
            filter: "inList:favourite[uuid]"
            height: 220

            LazyContent {
                Column { 
                    weight:1

                    Box {
                        width: 130

                        AsyncImage{
                            src: "<pictureurl>" 
                            width: 120 
                            link: "<url>"
                        }
                        Image{
                            src: "herz.png"
                            padding: "5 15 0 0" 
                            width: 48 
                            height: 48 
                            align: "topEnd"
                            link: "remove:favourite[<uuid>]"
                        }
                    }
                }
                Spacer {amount: 8}
            }

            LazyNoContent {
                Markdown { text: "Sie haben noch kein Buch zu ihren Favoriten gemacht..."
                }
            }
        }  
        
        Spacer {amount: 16}
        Markdown {
            color: "#4C9BD9"
            text: "# Novaj Eldonoj"
          }
        LazyRow {
            padding: "8"
            datasource: "books"
            filter: "notInList:favourite[uuid]"
            limit: 13
            order: "date"
            height: 220

            LazyContent {
                Column { 
                    weight:1
                    
                      Box {
                        width: 130
                        
                        AsyncImage{
                            src: "<pictureurl>" 
                            width: 120
                            link: "<url>"
                        }

                        Image{
                            src: "herz_outline.png"
                            padding: "5 15 0 0" 
                            width: 48
                            height: 48
                            align: "topEnd"
                            link: "add:favourite[<uuid>]"}
                    }
                }
                Spacer {amount: 8} 
            }
        }  
        Spacer { weight: 1 }
        Button { label: "Trovi Libroj" link: "page:app.books" }
    }
}