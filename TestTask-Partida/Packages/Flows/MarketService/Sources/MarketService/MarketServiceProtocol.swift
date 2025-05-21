import Foundation

public protocol MarketServiceProtocol {
    func fetchMarketList() async throws -> MarketListResponse
    func connectToWebSocket() async throws
    func disconnectWebSocket()
    func subscribeToMarkets(_ marketIds: [String]) async throws
    func receiveMarketUpdate() async throws -> WebSocketMessage
}
