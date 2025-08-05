import SwiftUI

public enum ActiveElement {
    case mention(String)
    case hashtag(String)
    case url(URL)
}

public struct ActiveLabelView: View {
    private let attributed: AttributedString
    private let onMentionTap: ((String) -> Void)?
    private let onHashtagTap: ((String) -> Void)?
    private let onURLTap: ((URL) -> Void)?

    public init(
        text: String,
        onMentionTap: ((String) -> Void)? = nil,
        onHashtagTap: ((String) -> Void)? = nil,
        onURLTap: ((URL) -> Void)? = nil
    ) {
        self.attributed = ActiveLabelView.makeAttributedString(from: text)
        self.onMentionTap = onMentionTap
        self.onHashtagTap = onHashtagTap
        self.onURLTap = onURLTap
    }

    public var body: some View {
        Text(attributed)
            .onOpenURL { url in
                switch url.scheme {
                    case "mention":
                        onMentionTap?(url.host ?? "")
                    case "hashtag":
                        onHashtagTap?(url.host ?? "")
                    case "http", "https":
                        onURLTap?(url)
                    default:
                        break
                }
            }
    }

    public static func makeAttributedString(from text: String) -> AttributedString {
        var result = AttributedString()
        let regex = try! NSRegularExpression(
            pattern: "(#[a-zA-Z0-9_]+)|(@[a-zA-Z0-9_]+)|(https?://[a-zA-Z0-9./]+)|(\\$[0-9]+(?:\\.[0-9]{1,2})?)|(\\$[a-zA-Z_]+)",
            options: []
        )
        
        let nsText = text as NSString
        let matches = regex.matches(in: text, range: NSRange(location: 0, length: nsText.length))
        var currentIndex = 0

        for match in matches {
            let range = match.range
            if range.location > currentIndex {
                let normalText = nsText.substring(with: NSRange(location: currentIndex, length: range.location - currentIndex))
                result += AttributedString(normalText)
            }

            let matched = nsText.substring(with: range)
            var attrText = AttributedString(matched)

            if matched.hasPrefix("@") {
                attrText.foregroundColor = .blue
                attrText.link = URL(string: "mention://\(matched.dropFirst())")
            } else if matched.hasPrefix("#") {
                attrText.foregroundColor = .green
                attrText.link = URL(string: "hashtag://\(matched.dropFirst())")
            } else if matched.starts(with: "http") {
                attrText.foregroundColor = .purple
                attrText.underlineStyle = .single
                attrText.link = URL(string: matched)
            } else if matched.starts(with: "$") {
                attrText.foregroundColor = .orange
                attrText.link = URL(string: "dollar://\(matched.dropFirst())")
            }

            result += attrText
            currentIndex = range.location + range.length
        }

        if currentIndex < nsText.length {
            result += AttributedString(nsText.substring(from: currentIndex))
        }

        return result
    }

}
