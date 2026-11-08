import CMSOrbit
import SwiftUI

struct PageScreen: View {
    let path: String
    @State private var state = LoadState.loading
    @Environment(\.openURL) private var openURL
    @Environment(\.scenePhase) private var scenePhase

    enum LoadState {
        case loading
        case page(CMSPage)
        case notFound
        case failed(String)
    }

    var body: some View {
        Group {
            switch state {
            case .loading:
                ProgressView()
            case .page(let page):
                PageView(page: page)
                    .refreshable { await load(path, fresh: true) }
            case .notFound:
                ContentUnavailableView("Page not found", systemImage: "map", description: Text("Nothing is published at \(path)."))
            case .failed(let message):
                ContentUnavailableView("The page could not be loaded", systemImage: "wifi.exclamationmark", description: Text(message))
            }
        }
        .task(id: path) { await load(path) }
        .onChange(of: scenePhase) { _, phase in
            if phase == .active {
                Task { await load(path) }
            }
        }
    }

    private func load(_ path: String, fresh: Bool = false) async {
        do {
            switch try await PageCache.shared.resolve(path, fresh: fresh) {
            case .page(let page):
                state = .page(page)
            case .redirect(let redirect):
                if redirect.to.hasPrefix("/") {
                    await load(redirect.to, fresh: fresh)
                } else if let url = URL(string: redirect.to) {
                    openURL(url)
                }
            case .gone, .notFound:
                state = .notFound
            }
        } catch is CancellationError {
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}

struct PageView: View {
    let page: CMSPage

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 40) {
                ForEach(page.components) { BlockView(block: $0) }
            }
            .padding()
        }
        .navigationTitle(page.name)
        .toolbar {
            if let seo = page.seo, let url = URL(string: seo.canonical) {
                ToolbarItem {
                    ShareLink(item: url, subject: Text(seo.title), message: Text(seo.description))
                }
            }
        }
    }
}
