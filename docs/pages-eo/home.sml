Page {
    padding: "8"
    title: "FreeBookReader"

    Column {
        padding: "8"
                        
        Markdown {
            color: "#4C9BD9"
            text: "# Willkommen"
          }
        LazyRow {
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book&filter=favourite"

            Column {
                weight: 1
                 Image { 
                    src: "<pictureurl>" 
                    width: 90
                    link: "<link>"
                }
            }
        }  

        Spacer { weight: 1 }
        Button { label: "Bücher" link: "page:app.books" }
    }
}