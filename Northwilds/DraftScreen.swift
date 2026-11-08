import CMSOrbit
import SwiftUI

struct PreviewLink: Identifiable {
    let token: String
    var id: String { token }
}

struct DraftScreen: View {
    let link: PreviewLink
    @State private var page: CMSPage?
    @State private var message: String?

    var body: some View {
        NavigationStack {
            if let page {
                PageView(page: page)
            } else if let message {
                ContentUnavailableView("No preview", systemImage: "eye.slash", description: Text(message))
            } else {
                ProgressView()
            }
        }
        .task {
            do {
                page = try await Self.draft(token: link.token)
            } catch {
                message = "The preview link has expired. Open it again from the editor."
            }
        }
    }

    static func draft(token: String) async throws -> CMSPage {
        var address = URLComponents(url: CMSSettings.draftServerURL, resolvingAgainstBaseURL: false)!
        address.queryItems = [URLQueryItem(name: "token", value: token)]
        let (data, response) = try await URLSession.shared.data(from: address.url!)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw URLError(.userAuthenticationRequired) }
        return try JSONDecoder().decode(CMSPage.self, from: data)
    }
}
