import XCTest
@testable import MarketsScreen
import MarketService
import Foundation

final class MarketsScreenTests: XCTestCase {

    private func decodeMarketListResponse(from json: String) -> MarketListResponse {
        let data = Data(json.utf8)
        return try! JSONDecoder().decode(MarketListResponse.self, from: data)
    }

    private func makeMarketListResponseFromJSON() -> MarketListResponse {
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

    func testExtractSecondComponent() {
        let service = DummyMarketService(response: makeMarketListResponseFromJSON())
        let vm = MarketsViewModel(args: .init(marketService: service))
        XCTAssertEqual(vm.extractSecondComponent(from: "BTC/USDT"), "USDT")
        XCTAssertEqual(vm.extractSecondComponent(from: "INVALID"), "INVALID")
    }

    func testAdjustedChange() {
        XCTAssertEqual(MarketsViewModel.adjustedChange(last: "100", open: "0"), 0)
        XCTAssertEqual(MarketsViewModel.adjustedChange(last: "abc", open: "100"), 0)
    }

    func testMakePairCellViewModels() {
        let json = """
        {
          "response": {
            "tabs": {},
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
        let response = decodeMarketListResponse(from: json)
        let service = DummyMarketService(response: makeMarketListResponseFromJSON())
        let vm = MarketsViewModel(args: .init(marketService: service))
        vm.makePairCellViewModels(currencies: response.response.currencies)
        let model = vm.pairs["BTC_USDT"]
        XCTAssertEqual(model?.crypto, "BTC")
        XCTAssertEqual(model?.fiat, "USDT")
        XCTAssertEqual(model?.price, 10000)
        XCTAssertEqual(model?.change, 5)
    }

    func testMakeTagModels() {
        let json = """
        {
          "response": {
            "tabs": {
              "BTC": ["BTC"],
              "DeFi": ["DEFI"],
              "USDs": ["USDT"],
              "OTHER": ["OTHER"]
            },
            "currencies": {}
          }
        }
        """
        let response = decodeMarketListResponse(from: json)
        let service = DummyMarketService(response: makeMarketListResponseFromJSON())
        let vm = MarketsViewModel(args: .init(marketService: service))
        vm.makeTagModels(tabs: response.response.tabs)
        XCTAssertEqual(vm.tagsBtc.count, 1)
        XCTAssertTrue(vm.tagsUsds.first?.isSelected ?? false)
        XCTAssertTrue(vm.tabsWithLine.first?.isSelected ?? false)
    }

    func testSortedPairs() {
        let json = """
        {
          "response": {
            "tabs": {},
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
              },
              "ETH_USDT": {
                "tabName": "ETH/USDT",
                "pairName": "ETH/USDT",
                "favorite": false,
                "id": 2,
                "isSto": false,
                "stock_icon": null,
                "money_icon": null,
                "stock_label": null,
                "money_label": null,
                "price": "2000",
                "priceUsd": "2000",
                "high": null,
                "change": "2",
                "low": null,
                "volume": "1000000",
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
        let response = decodeMarketListResponse(from: json)
        let service = DummyMarketService(response: makeMarketListResponseFromJSON())
        let vm = MarketsViewModel(args: .init(marketService: service))
        vm.makePairCellViewModels(currencies: response.response.currencies)
        vm.activeTag = "USDT"
        vm.currentSort = .volumeDescending
        let result = vm.sortedPairs()
        XCTAssertEqual(result.first?.crypto, "ETH")
    }
}
