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
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&filter=favourite"
            height: 220

            LazyContent {
                Column { 
                    weight:1
                    
                    Image { 
                        src: "<pictureurl>" 
                        width: 120
                        link: "<url>"
                    }
                }
                Spacer {amount: 8}
            }

            LazyNoContent {
                MarkDown { text: "Hier gibt es nichts zu sehen..."}
            }
        }  
        
        Spacer {amount: 16}
        Markdown {
            color: "#4C9BD9"
            text: "# Neuerscheinungen"
          }
        LazyRow {
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&limit=13"
            height: 220

            LazyContent {
                Column { 
                    weight:1
                    
                    Image { 
                        src: "<pictureurl>" 
                        width: 120
                        link: "<url>"
                    }
                }
                Spacer {amount: 8}
            }
        }  

        Spacer { weight: 1 }
        Button { label: "Bücher Finden" link: "page:app.books" }
    }
}