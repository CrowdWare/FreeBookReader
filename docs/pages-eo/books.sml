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
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book" 
            weight: 1

            LazyContent {
                Row {
                    padding: "8"
              
                    Image { 
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
            }
        }

        Spacer {amount: 8}
        Button {label: "Home" link: "page:app.home" }       

        

    }
}