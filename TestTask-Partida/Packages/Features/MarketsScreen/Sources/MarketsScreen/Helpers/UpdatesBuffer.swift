import Foundation
import MarketService

actor UpdatesBuffer {
    private var storage: [String: MarketUpdate.Stats] = [:]

    func set(symbol: String, stats: MarketUpdate.Stats) {
        storage[symbol] = stats
    }

    func snapshotAndClear() -> [String: MarketUpdate.Stats] {
        let snapshot = storage
        storage.removeAll()
        return snapshot
    }
}
