import CMSOrbit
import Foundation

actor PageCache {
    static let shared = PageCache()

    private let lifetime: TimeInterval = 5 * 60
    private var entries: [String: (resolution: CMSResolution, loadedAt: Date)] = [:]

    func resolve(_ path: String, fresh: Bool = false) async throws -> CMSResolution {
        if !fresh, let entry = entries[path], Date.now.timeIntervalSince(entry.loadedAt) < lifetime {
            return entry.resolution
        }
        do {
            let resolution = try await cms.resolve(path)
            entries[path] = (resolution, .now)
            return resolution
        } catch {
            if let entry = entries[path] { return entry.resolution }
            throw error
        }
    }

    func clear() {
        entries.removeAll()
    }
}
