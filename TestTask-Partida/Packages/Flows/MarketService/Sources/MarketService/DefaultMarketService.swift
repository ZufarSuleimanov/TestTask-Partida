import Foundation
import NetworkClient
import WebSocketClient

public struct DefaultMarketService: MarketServiceProtocol {
    private let networkClient: NetworkClientProtocol
    private let webSocketClient: WebSocketClientProtocol

    public init(
        networkClient: NetworkClientProtocol = DefaultNetworkClient(baseURL: URL(string: "https://p2pb2b.com/")!),
        webSocketClient: WebSocketClientProtocol = DefaultWebSocketClient(url: URL(string: "wss://ws.p2pb2b.com/ws")!)
    ) {
        self.networkClient = networkClient
        self.webSocketClient = webSocketClient
    }

    public func fetchMarketList() async throws -> MarketListResponse {
        let endpoint = Endpoint(path: "v2/market-list/new")
        return try await networkClient.request(endpoint: endpoint)
    }

    public func connectToWebSocket() async throws {
        try await webSocketClient.connect()
    }

    public func disconnectWebSocket() {
        webSocketClient.disconnect()
    }

    public func subscribeToMarkets(_ marketIds: [String]) async throws {
        let message = WebSocketSubscriptionMessage(
            method: "state.subscribe",
            params: marketIds,
            id: 1
        )
        try await webSocketClient.send(message)
    }

    public func receiveMarketUpdate() async throws -> WebSocketMessage {
        return try await webSocketClient.receive()
    }
}
