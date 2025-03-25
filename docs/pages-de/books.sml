Page {
    padding: "8"
    title: "NoCodeLibMobile"
   

    Column {
        padding: "8"
                        
        Markdown {
            color: "#4C9BD9"
            text: "# Bücher Finden"
        }
        Markdown {
            text: "Hier findest Du eine Liste aller veröffentlichten Bücher."
        }
        Spacer {amount: 8}


        LazyColumn {
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&locale=de" 
            weight: 1

            LazyContent {
                Row {
                    padding: "8"
              
                    Box {
                        width: 120

                        AsyncImage{
                            src: "<pictureurl>" 
                            width: 120 
                            link: "<url>"
                        }
                        Image{
                            src: "herz.png" 
                            width: 32 
                            height: 32 
                            align: "topEnd"
                            link: "add:favourite[<uuid>]"}
                    }                        
                    
                    Spacer {amount: 8}
                    Markdown {
                        weight: 1
                        text: "<description>"
                    }
                    Spacer {amount: 8}
                }
            }
        }

        Spacer {amount: 8}
        Button {label: "Home" link: "page:app.home" }
    }
}