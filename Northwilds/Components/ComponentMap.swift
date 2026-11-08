import CMSOrbit
import SwiftUI

@MainActor
enum ComponentMap {
    static let views: [String: (CMSComponent) -> AnyView] = [
        HeroBlock.blockType: view(HeroBlock.self) { HeroView(hero: $0, block: $1) },
        FeatureSpotlightBlock.blockType: view(FeatureSpotlightBlock.self) { FeatureSpotlightView(spotlight: $0, block: $1) },
        ActionBlock.blockType: view(ActionBlock.self) { action, _ in ActionView(action: action) },
    ]

    private static func view<Fields: CMSBlockFields, Content: View>(
        _ type: Fields.Type,
        _ make: @escaping (Fields, CMSComponent) -> Content
    ) -> (CMSComponent) -> AnyView {
        { block in
            guard let fields = try? block.decode(Fields.self) else { return AnyView(UnknownBlockView(block: block)) }
            return AnyView(make(fields, block))
        }
    }
}

struct BlockView: View {
    let block: CMSComponent

    var body: some View {
        if let make = ComponentMap.views[block.type] {
            make(block)
        } else {
            UnknownBlockView(block: block)
        }
    }
}

struct SlotView: View {
    let block: CMSComponent
    let slot: String

    var body: some View {
        ForEach(block.children[slot] ?? []) { BlockView(block: $0) }
    }
}

struct UnknownBlockView: View {
    let block: CMSComponent

    var body: some View {
        #if DEBUG
        Text("No view for \(block.type)")
            .font(.caption.monospaced())
            .foregroundStyle(.secondary)
        #endif
    }
}
