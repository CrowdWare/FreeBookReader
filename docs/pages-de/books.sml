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
  		Row {
  			padding: "8"
  			
			Image { src: "DieReiseZumWahrenLeben.png" weight: 1 link: "book:https://github.com/Artananda/DieReiseZumWahrenLeben/app.sml"}
			Spacer {amount: 8}
			
				
			Markdown {
				weight: 1
				text: "**Die Reise zum wahren**
					**Leben**
					*Adam Art Ananda*
					Neuauflage von 'Die Kunst
					zu Leben und zu Lieben'
					Eigentlich habe ich es für
					meinen Sohn geschrieben.
					Da Du aber auch ein Sohn bist
					könnte es ja auch für Dich 
					interessant sein, und wenn
					nicht, ist es ja auch nicht
					so schlimm.
					"
			}
		}
		
		Spacer {amount: 8}
  		Row {
  			padding: "8"
  			
			Image { src: "SpielDesLebens.png" weight: 1 link: "book:https://crowdware.github.io/DeinLeben/app.sml"}
			Spacer {amount: 8}
			Markdown {
				text: "**Spiel des Leben**
					*Adam Art Ananda*
					
					Hier findest Du mehrere
					Bücher in einem Band.
					Du kannst in diesem Buch 
					Deinen eigenen Weg wählen.
					Das erste interaktive Buch,
					das wir mit dem FreeBook-
					Designer hergestellt haben.
					Es dient aiuch als Beispiel
					des Machbaren.
					" 
				weight: 1
			}
		}
  		Spacer {amount: 8}
  		Button {label: "Print Ausgaben und Ebooks" link: "web:http://books.crowdware.at/index_de.html"}
  		Button {label: "Home" link: "page:app.home" }
    }
}