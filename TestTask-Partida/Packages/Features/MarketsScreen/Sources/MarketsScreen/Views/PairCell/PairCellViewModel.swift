import Foundation
import Observation

@Observable
final class PairCellViewModel: Identifiable {
    let id = UUID()
    let key: String
    let crypto: String
    let fiat: String
    var volume: String
    var price: Double
    var priceUsd: Double
    var change: Double
    
    var volumeDouble: Double {
        Double(volume) ?? 0
    }

    init(
        key: String,
        pairName: String,
        volume: String,
        price: Double,
        priceUsd: Double,
        change: Double
    ) {
        self.key = key
        let names = PairCellViewModel.splitPair(pairName)
        self.crypto = names?.base ?? ""
        self.fiat = names?.quote ?? ""
        self.volume = volume
        self.price = price
        self.priceUsd = priceUsd
        self.change = change
    }
    
    static func splitPair(_ pair: String) -> (base: String, quote: String)? {
        let components = pair.split(separator: "/")
        guard components.count == 2 else { return nil }
        return (base: String(components[0]), quote: String(components[1]))
    }
}
