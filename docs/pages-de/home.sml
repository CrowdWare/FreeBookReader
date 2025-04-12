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
            padding: "8"
            datasource: "books"
            filter: "inList:favourite[uuid]"
            height: 220

            LazyContent {
                Row {
                    Column { 
                        weight:1

                        Box {
                            width: 120

                            AsyncImage{
                                src: "<pictureurl>" 
                                width: 120 
                                link: "<url>"
                            }
                            Image{
                                src: "herz.png"
                                padding: "5" 
                                width: 32 
                                height: 32 
                                align: "topEnd"
                                link: "remove:favourite[<uuid>]"
                            }
                        }
                    }
                    Spacer {amount: 8}
                }
            }

            LazyNoContent {
                Markdown { text: "Sie haben noch kein Buch zu ihren Favoriten gemacht..."
                }
            }
        }  
        
        Spacer {amount: 16}
        Markdown {
            color: "#4C9BD9"
            text: "# Neuerscheinungen"
        }
        LazyRow {
            padding: "8"
            datasource: "books"
            filter: "notInList:favourite[uuid]"
            limit: 13
            order: "date"
            height: 220

            LazyContent {
                Row {
                    Column { 
                        weight:1
                    
                          Box {
                            width: 120
                        
                            AsyncImage{
                                src: "<pictureurl>" 
                                width: 120
                                link: "<url>"
                            }

                            Image{
                                src: "herz_outline.png"
                                padding: "5" 
                                width: 32
                                height: 32
                                align: "topEnd"
                                link: "add:favourite[<uuid>]"}
                        }
                    }
                    Spacer {amount: 8}
                }
            }
        }  
        
        Spacer { weight: 1 }
        YouAreNotAlone {
            message: "Wenn Du das hier gefunden hast, dann bist Du einer von uns."
            url: "https://yana.crowdware.at"
        }
        Button { label: "Bücher Finden" link: "page:app.books" }
    }
}