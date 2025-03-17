Page {
    padding: "8"
    title: "FreeBookReader"
    scrollable: "true"

    Column {
        padding: "8"
                        
        Markdown {
            color: "#4C9BD9"
            text: "# Libroj."
        }
        Markdown {
            text: "Jen listo de la nuntempe disponeblaj libroj."
        }
        Spacer {amount: 8}

        LazyColumn {
            url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book" 

            Row {
                padding: "8"
              
                Image { 
                    src: "<pictureurl>" 
                    width: 50
                    weight: 1
                    link: "<link>"
                }
                Spacer {amount: 8}
                Markdown {
                    weight: 1
                    text: "<description>"
                }
                Spacer {amount: 8}
            }
        }

        Spacer {amount: 8}
        Button {label: "Home" link: "page:app.home" }       
    }
}