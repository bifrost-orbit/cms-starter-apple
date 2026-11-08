import CMSOrbit
import SwiftUI

struct HeroView: View {
    let hero: HeroBlock
    let block: CMSComponent

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let eyebrow = hero.eyebrow {
                Text(eyebrow.uppercased())
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            Text(hero.heading)
                .font(.largeTitle.bold())
            if let accent = hero.headingAccent {
                Text(accent)
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
            if let description = hero.description {
                RichText(html: description)
            }
            HStack {
                SlotView(block: block, slot: "primaryAction")
                SlotView(block: block, slot: "secondaryAction")
            }
        }
    }
}
