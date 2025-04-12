# 📚 FreeBookReader

**FreeBookReader** is an offline-capable, privacy-friendly, and freely extensible reader for e-books, interactive content, and NoCode apps — based on the declarative language **SML (Simple Markup Language)**.

---

## ✨ Features

- 📄 **Parses SML files** – a lightweight declarative language similar to HTML or QML
- 📚 **Displays interactive books & apps**
- 📦 **Loads content via REST APIs or local JSON mocks**
- 🧠 **Filtering, favorites, dynamic lists** (via SharedPreferences)
- 🎨 **Custom theming** through simple attributes
- 🔌 **Plugin system**: extendable with `.jar` modules (e.g., Ebook, WebService, Database)
- 💾 **Fully offline capable** – perfect for flight mode, workshops, demos, or the apocalypse 🛸
- 🌐 **Optional online access to IPFS or remote data**
- 📡 **Compatible with NoCodeDesigner & smile CLI**

---

## 🚀 Getting Started

### 1. Clone the project

```bash
git clone https://github.com/yourname/FreeBookReader.git
cd FreeBookReader
```

### 2. Run the desktop project

```bash
./gradlew run
```

### 3. Test in airplane mode 😄  
FreeBookReader supports loading local `.sml` and `.json` files – perfect for offline testing.

---

## 🔧 Example `App.sml`

```sml
App {
    RestDatasource {
        id: "books"
        url: "https://example.com/api/books"
        mock: "books.json"
    }

    Page {
        LazyRow {
            datasource: "books"
            filter: "notInList:favourite[uuid]"
            order: "date desc"
            spacing: "8"

            LazyContent {
                Row {
                    Box {
                        AsyncImage { src: "<pictureurl>" }
                        Image {
                            src: "herz_outline.png"
                            link: "add:favourite[<uuid>]"
                        }
                    }
                    Spacer { amount: 8 }
                }
            }
        }

        YouAreNotAlone {
            message: "If you found this, you are one of us."
            url: "https://yana.crowdware.at"
        }
    }
}
```

---

## 🌍 Philosophy

> Read freely. Create freely. Without gatekeepers.  
> If needed: **burned onto IPFS for eternity.** 🔥

---

## ❤️ Community & Manifest

FreeBookReader is part of the [YANA Project](https://yana.crowdware.at)  
(**You Are Not Alone**) – for freedom, self-determination, and digital literacy.  
Join us as a developer, author, or supporter.

---

## 📦 License

GPL-3 License – free to use, fork, and modify.  
The world needs more free books. And free readers. 📖✨