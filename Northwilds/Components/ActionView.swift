import SwiftUI

struct ActionView: View {
    let action: ActionBlock

    var body: some View {
        if let href = action.link?.href, let url = URL(string: href) {
            if action.style == "primary" {
                Link(action.label, destination: url).buttonStyle(.borderedProminent)
            } else {
                Link(action.label, destination: url).buttonStyle(.bordered)
            }
        }
    }
}
