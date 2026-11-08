import CMSOrbit
import SwiftUI

struct CMSAddress: Hashable {
    let path: String
}

struct ContentView: View {
    @State private var stack: [CMSAddress] = []
    @State private var menu: [CMSNavItem] = []
    @State private var preview: PreviewLink?
    @Environment(\.openURL) private var openOutside

    var body: some View {
        NavigationStack(path: $stack) {
            PageScreen(path: "/")
                .navigationDestination(for: CMSAddress.self) { PageScreen(path: $0.path) }
                .toolbar {
                    ToolbarItem {
                        Menu {
                            ForEach(menu, id: \.self) { item in
                                if item.children.isEmpty {
                                    Button(item.label) { open(item.href) }
                                } else {
                                    Menu(item.label) {
                                        ForEach(item.children, id: \.self) { child in
                                            Button(child.label) { open(child.href) }
                                        }
                                    }
                                }
                            }
                        } label: {
                            Label("Menu", systemImage: "line.3.horizontal")
                        }
                    }
                }
        }
        .environment(\.openURL, OpenURLAction { url in
            guard let path = Self.appPath(url) else { return .systemAction }
            stack.append(CMSAddress(path: path))
            return .handled
        })
        .onOpenURL { url in
            if let token = CMSOrbitClient.previewToken(from: url) {
                preview = PreviewLink(token: token)
            } else if let path = Self.appPath(url) {
                stack = [CMSAddress(path: path)]
            }
        }
        .sheet(item: $preview) { DraftScreen(link: $0) }
        .task {
            menu = (try? await cms.navigation("header").items) ?? []
        }
    }

    private func open(_ href: String?) {
        guard let href, let url = URL(string: href) else { return }
        if let path = Self.appPath(url) {
            stack.append(CMSAddress(path: path))
        } else {
            openOutside(url)
        }
    }

    static func appPath(_ url: URL) -> String? {
        guard url.host == nil || url.host == CMSSettings.websiteHost else { return nil }
        return url.path.isEmpty ? "/" : url.path
    }
}
