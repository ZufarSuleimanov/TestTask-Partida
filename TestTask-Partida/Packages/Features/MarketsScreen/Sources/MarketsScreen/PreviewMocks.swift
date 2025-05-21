import SwiftUI
import MarketService

final class DummyMarketService: MarketServiceProtocol {
    private let response: MarketListResponse

    init(response: MarketListResponse) {
        self.response = response
    }

    func fetchMarketList() async throws -> MarketListResponse {
        return response
    }

    func connectToWebSocket() async throws {}
    func disconnectWebSocket() {}
    func subscribeToMarkets(_ marketIds: [String]) async throws {}
    func receiveMarketUpdate() async throws -> WebSocketMessage {
        throw CancellationError()
    }
}

func makeMarketListResponseFromJSON() -> MarketListResponse {
    let json = """
    {
      "response": {
        "tabs": {
          "BTC": ["BTC"],
          "DeFi": ["DEFI"],
          "USDs": ["USDT"],
          "OTHER": ["OTHER"]
        },
        "currencies": {
          "BTC_USDT": {
            "tabName": "BTC/USDT",
            "pairName": "BTC/USDT",
            "favorite": false,
            "id": 1,
            "isSto": false,
            "stock_icon": null,
            "money_icon": null,
            "stock_label": null,
            "money_label": null,
            "price": "10000",
            "priceUsd": "10000",
            "high": null,
            "change": "5",
            "low": null,
            "volume": "500000",
            "deal": null,
            "priority": 0,
            "min_amount": null,
            "max_amount": null,
            "step_size": null,
            "min_price": null,
            "max_price": null,
            "tick_size": null,
            "min_total": null,
            "stock_precision": 0,
            "money_precision": 0,
            "new": false,
            "zeroFee": false,
            "preDelisting": false
          }
        }
      }
    }
    """
    let data = Data(json.utf8)
    return try! JSONDecoder().decode(MarketListResponse.self, from: data)
}

func makeStatsFromJSON(_ json: String) -> MarketUpdate.Stats {
    try! JSONDecoder().decode(MarketUpdate.Stats.self, from: Data(json.utf8))
}
