Page {
    padding: "8"
    title: "string:about"
    scrollable: true
    
    Column {
        padding: "8"

        Markdown {text: "# string:aboutapp" }
        Spacer {amount: 8 }
        Markdown {text: "part:part1" }
        Spacer {amount: 8}
        Row {
            Markdown {text: "part:part2"}
            Spacer {amount: 8}
            Image { src: "menu.png" scale:"fit"}
        }
        Spacer {amount: 8}
        Markdown {text: "part:part3"}
        Spacer {amount: 8 }
        Button {label: "string:home" link: "page:app.home" }
    }
}