import CMSOrbit

struct HeroBlock: CMSBlockFields {
    static let blockType = "hero"
    var eyebrow: String?
    var heading: String
    var headingAccent: String?
    var description: CMSRichText?
}

struct FeatureSpotlightBlock: CMSBlockFields {
    static let blockType = "featureSpotlight"
    var eyebrow: String?
    var heading: String
    var body: CMSRichText?
    var image: CMSImage?
}

struct ActionBlock: CMSBlockFields {
    static let blockType = "action"
    var label: String
    var link: CMSLink?
    var style: String?
}
