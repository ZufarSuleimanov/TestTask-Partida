import Foundation

public struct MarketListResponse: Codable, Sendable {
    public let response: Response
}

// MARK: - Response
public struct Response: Codable, Sendable {
    public let tabs: Tabs
    public let currencies: [String: CurrencyInfo]
}

// MARK: - TabsValue
public enum TabsValue: Codable, Sendable {
    case string(String)
    case array([String])
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let str = try? container.decode(String.self) {
            self = .string(str)
        } else if let arr = try? container.decode([String].self) {
            self = .array(arr)
        } else {
            throw DecodingError
                .typeMismatch(
                    TabsValue.self,
                    DecodingError
                        .Context(
                            codingPath: decoder.codingPath,
                            debugDescription: "Expected String or [String]"
                        )
                )
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let str): try container.encode(str)
        case .array(let arr): try container.encode(arr)
        }
    }
    
    public var values: [String] {
        switch self {
        case .string(let s): return [s]
        case .array(let a): return a
        }
    }
}

// MARK: - Tabs
public struct Tabs: Codable, Sendable {
    public let ALTS: TabsValue?
    public let BTC: TabsValue?
    public let DeFi: TabsValue?
    public let OTHER: TabsValue?
    public let USDs: TabsValue?
}

// MARK: - CurrencyInfo
public struct CurrencyInfo: Codable, Sendable {
    public let tabName: String
    public let pairName: String
    public let favorite: Bool
    public let id: Int
    public let isSto: Bool
    public let stockIcon: URL?
    public let moneyIcon: URL?
    public let stockLabel: String?
    public let moneyLabel: String?
    public let price: String?
    public let priceUsd: String?
    public let high: String?
    public let change: String?
    public let low: String?
    public let volume: String?
    public let deal: String?
    public let priority: Int
    public let minAmount: String?
    public let maxAmount: String?
    public let stepSize: String?
    public let minPrice: String?
    public let maxPrice: String?
    public let tickSize: String?
    public let minTotal: String?
    public let stockPrecision: Int
    public let moneyPrecision: Int
    public let new: Bool
    public let zeroFee: Bool
    public let preDelisting: Bool
    
    enum CodingKeys: String, CodingKey {
        case tabName, pairName, favorite, id, isSto
        case stockIcon = "stock_icon"
        case moneyIcon = "money_icon"
        case stockLabel = "stock_label"
        case moneyLabel = "money_label"
        case price, priceUsd = "priceUsd"
        case high, change, low, volume, deal, priority
        case minAmount = "min_amount"
        case maxAmount = "max_amount"
        case stepSize = "step_size"
        case minPrice = "min_price"
        case maxPrice = "max_price"
        case tickSize = "tick_size"
        case minTotal = "min_total"
        case stockPrecision = "stock_precision"
        case moneyPrecision = "money_precision"
        case new, zeroFee, preDelisting
    }
}
