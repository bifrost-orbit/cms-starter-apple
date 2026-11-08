import SwiftUI

struct RichText: View {
    let html: String

    var body: some View {
        Text(Self.attributed(html))
    }

    static func attributed(_ html: String) -> AttributedString {
        let styled = "<style>body { font-family: -apple-system; font-size: 17px; }</style>" + html
        guard let string = try? NSMutableAttributedString(
            data: Data(styled.utf8),
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil
        ) else {
            return AttributedString(html)
        }
        string.removeAttribute(.foregroundColor, range: NSRange(location: 0, length: string.length))
        while string.string.hasSuffix("\n") {
            string.deleteCharacters(in: NSRange(location: string.length - 1, length: 1))
        }
        return AttributedString(string)
    }
}
