Page {
    padding: "8"
    title: "FreeBookReader"

    Column {
        padding: "8"
                        
        Markdown {
            color: "#4C9BD9"
            text: "# Willkommen"
          }
                    

        Spacer { weight: 1 }
        Row {       
            Button { label: "About FreeBook" link: "page:app.about"}
            Spacer { amount: 8}
            Button { label: "Bücher" link: "page:app.books" }            
        }
    }
}