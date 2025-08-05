# ActiveLabelSwiftUI

`ActiveLabelSwiftUI` is a lightweight SwiftUI-compatible component that parses and highlights mentions (`@username`), hashtags (`#topic`), dollar (`#$value`) and URLs in text — with support for tap detection.

Ideal for building timelines, comment sections, or posts like in Twitter or Facebook.

---

## ✨ Features

- Detects `@mentions`, `#hashtags`, `$1000` , and `URLs`
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
            text: "Check out @Ali's #SwiftUI post at https://example.com for $100!",
            onMentionTap: { mention in print("Tapped mention: \(mention)") },
            onHashtagTap: { hashtag in print("Tapped hashtag: \(hashtag)") },
            onURLTap: { url in print("Tapped URL: \(url)") },
            onDollarTap: { amount in print("Tapped dollar: \(amount)") }
        )
    }
}
```

### Basic Example Precomputing Attributed String (for performance)

```swift
import ActiveLabelSwiftUI

let attrString = ActiveLabelView.makeAttributedString(from: "Check out @Ali's #SwiftUI post at https://example.com for $100!")


Text(attrString)
    .environment(\.openURL, OpenURLAction { url in
        switch url.scheme {
        case "mention":
            print("Mention tapped:", url.host ?? "")
            return .handled
        case "hashtag":
            print("Hashtag tapped:", url.host ?? "")
            return .handled
        case "dollar":
            print("Dollar tapped:", url.host ?? "")
            return .handled
        case "http", "https":
            print(url.absoluteString)
            return .handled
        default:
            return .systemAction
        }
    })
```
