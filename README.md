# ActiveLabelSwiftUI

`ActiveLabelSwiftUI` is a lightweight SwiftUI-compatible component that parses and highlights mentions (`@username`), hashtags (`#topic`), and URLs in text — with support for tap detection.

Ideal for building timelines, comment sections, or posts like in Twitter or Facebook.

---

## ✨ Features

- Detects `@mentions`, `#hashtags`, and `URLs`
- Custom colors and font styling
- Tap actions for all link types
- Supports pre-computed attributed strings (for performance)
- Works seamlessly with `LazyVStack` or timeline-like views

---

## 📦 Installation

### Using Swift Package Manager (SPM)

1. Go to **Xcode > File > Add Packages**
2. Enter the URL of this repo:
3. Choose **version** (e.g. from `1.0.0`) and add the package.

---

## 🧑‍💻 Usage

### Basic Example

```swift
import ActiveLabelSwiftUI

struct ContentView: View {
    var body: some View {
        ActiveLabelView(
            text: "Hello @ali! Visit https://apple.com or use #SwiftUI",
            onOpenLink: { url in
                print("Tapped URL: \(url)")
            },
            onTapMention: { mention in
                print("Tapped Mention: \(mention)")
            },
            onTapHashtag: { hashtag in
                print("Tapped Hashtag: \(hashtag)")
            }
        )
        .padding()
    }
}
```

### Basic Example Precomputing Attributed String (for performance)

```swift
import ActiveLabelSwiftUI

let attributed = ActiveLabelView.makeAttributedString(
    "Welcome @Ali to #iOSDev. Check https://github.com!",
    font: .systemFont(ofSize: 16),
    textColor: .label,
    linkColor: .blue
)

Text(attributed)
    .onTapGesture {
        // Tap detection won't work here directly
        // Use ActiveLabelView for tap handling
    }
```
