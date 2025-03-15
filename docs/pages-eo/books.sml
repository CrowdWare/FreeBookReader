Page {
    padding: "8"
    title: "FreeBookReader"
    scrollable: "true"

    Column {
        padding: "8"
                        
        Markdown {
            color: "#4C9BD9"
            text: "# Bücher"
          }
          Markdown {
            text: "Hier eine Liste der derzeit verfügbaren Bücher."
          }
          Spacer {amount: 8}
          Embed {url: "https://artanidos.pythonanywhere.com/crowdware/items?type=book"}          
          Spacer {amount: 8}
          Button {label: "Home" link: "page:app.home" }
    }
}