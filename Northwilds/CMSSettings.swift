import Foundation

enum CMSSettings {
    static let apiURL = URL(string: "https://api.bifrostorbit.com/cms")!
    static let publicKey = "cms_pk_…"
    static let region = "global"
    static let locale: String? = nil
    static let websiteHost = "northwilds.com"
    static let draftServerURL = URL(string: "https://northwilds.com/api/app-preview")!
}
