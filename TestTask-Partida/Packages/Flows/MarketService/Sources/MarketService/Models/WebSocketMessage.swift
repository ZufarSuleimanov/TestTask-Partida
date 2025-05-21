import Foundation

public enum WebSocketMessage: Decodable, Sendable {
    case result(WebSocketResult)
    case update(MarketUpdate)

    enum CodingKeys: String, CodingKey {
        case method, result, params
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let method = try? container.decode(String.self, forKey: .method), method == "state.update" {
            let update = try MarketUpdate(from: decoder)
            self = .update(update)
        } else if container.contains(.result) {
            let result = try container.decode(WebSocketResult.self, forKey: .result)
            self = .result(result)
        } else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: container.codingPath, debugDescription: "Unsupported message format")
            )
        }
    }
}

public struct WebSocketResult: Decodable, Sendable {
    public let status: String
}

public struct MarketUpdate: Decodable, Sendable {
    public let method: String
    public let params: MarketParams

    public struct MarketParams: Decodable, Sendable {
        public let symbol: String
        public let stats: Stats

        public init(from decoder: Decoder) throws {
            var container = try decoder.unkeyedContainer()
            self.symbol = try container.decode(String.self)
            self.stats = try container.decode(Stats.self)
        }
    }

    public struct Stats: Decodable, Sendable {
        public let period: Int
        public let last: String
        public let open: String
        public let close: String
        public let high: String
        public let low: String
        public let volume: String
        public let deal: String
    }
}
