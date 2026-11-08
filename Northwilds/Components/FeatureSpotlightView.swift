import CMSOrbit
import SwiftUI

struct FeatureSpotlightView: View {
    let spotlight: FeatureSpotlightBlock
    let block: CMSComponent

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let url = spotlight.image?.url(width: 1200) {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    Color.secondary.opacity(0.1).frame(height: 200)
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .accessibilityLabel(spotlight.image?.alt ?? "")
            }
            if let eyebrow = spotlight.eyebrow {
                Text(eyebrow.uppercased())
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            Text(spotlight.heading)
                .font(.title.bold())
            if let body = spotlight.body {
                RichText(html: body)
            }
            SlotView(block: block, slot: "action")
        }
    }
}
