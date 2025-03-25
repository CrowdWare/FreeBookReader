Page {
    padding: "8"
    title: "NoCodeLibMobile"
   

    Column {
        padding: "8"
                        
        Markdown {
            color: "#4C9BD9"
            text: "# Trouver des livres"
        }
        Markdown {
            text: "Vous trouverez ici une liste de tous les livres publiés."
        }
        Spacer {amount: 8}


        LazyColumn {
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&locale=fr" 
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