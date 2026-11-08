import CMSOrbit
import Foundation

let cms: CMSOrbitClient = {
    let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    configuration.urlCache = nil
    do {
        return try CMSOrbitClient(
            apiKey: CMSSettings.publicKey,
            baseURL: CMSSettings.apiURL,
            region: CMSSettings.region,
            locale: CMSSettings.locale,
            session: URLSession(configuration: configuration)
        )
    } catch {
        fatalError("Check CMSSettings.swift: \(error.localizedDescription)")
    }
}()
