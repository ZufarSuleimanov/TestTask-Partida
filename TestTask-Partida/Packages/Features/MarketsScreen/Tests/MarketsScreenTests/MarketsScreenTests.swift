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
        let data = Data(String.singleCurrency.utf8)
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
        let response = decodeMarketListResponse(from: String.singleCurrency)
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
        let response = decodeMarketListResponse(from: String.tabs)
        let service = DummyMarketService(response: makeMarketListResponseFromJSON())
        let vm = MarketsViewModel(args: .init(marketService: service))
        vm.makeTagModels(tabs: response.response.tabs)
        
        XCTAssertEqual(vm.tagsBtc.count, 1)
        XCTAssertTrue(vm.tagsUsds.first?.isSelected ?? false)
        XCTAssertTrue(vm.tabsWithLine.first?.isSelected ?? false)
    }

    func testSortedPairs() {
        let response = decodeMarketListResponse(from: String.currencies)
        let service = DummyMarketService(response: makeMarketListResponseFromJSON())
        let vm = MarketsViewModel(args: .init(marketService: service))
        vm.makePairCellViewModels(currencies: response.response.currencies)
        vm.activeTag = "USDT"
        vm.currentSort = .volumeDescending
        let result = vm.sortedPairs()
        
        XCTAssertEqual(result.first?.crypto, "ETH")
    }
    
    func testUpdatesBufferStoresAndClears() async {
        let buffer = UpdatesBuffer()

        let stats1 = try! JSONDecoder().decode(MarketUpdate.Stats.self, from: Data(String.stats1.utf8))
        let stats2 = try! JSONDecoder().decode(MarketUpdate.Stats.self, from: Data(String.stats2.utf8))

        await buffer.set(symbol: "BTC_USDT", stats: stats1)
        await buffer.set(symbol: "ETH_USDT", stats: stats2)

        let snapshot = await buffer.snapshotAndClear()
        XCTAssertEqual(snapshot.count, 2)
        XCTAssertEqual(snapshot["BTC_USDT"]?.last, "100")
        XCTAssertEqual(snapshot["ETH_USDT"]?.last, "200")

        let afterClear = await buffer.snapshotAndClear()
        XCTAssertTrue(afterClear.isEmpty)
    }
}
