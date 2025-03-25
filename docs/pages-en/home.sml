Page {
    padding: "8"
    title: "NoCodeLibMobile"

    Column {
        padding: "8"
                        
        Markdown {
            color: "#4C9BD9"
            text: "# Favouriten"
          }
        LazyRow {
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&locale=en&filter=inList:favourite[uuid]"
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
                Markdown { text: "## Hier gibt es nichts zu sehen..."}
            }
        }  
        
        Spacer {amount: 16}
        Markdown {
            color: "#4C9BD9"
            text: "# New releases"
          }
        LazyRow {
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&locale=en&limit=13&filter=notInList:favourite[uuid]"
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
        Button { label: "Find books" link: "page:app.books" }
    }
}