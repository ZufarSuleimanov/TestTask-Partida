import Factory
import Foundation
import NetworkMonitor
import NetworkClient
import MarketService
import WebSocketClient

extension Container {
    var networkMonitor: Factory<NetworkMonitoring> {
        self {
            NetworkMonitor()
        }
        .scope(.shared)
    }
    
    var networkClient: Factory<NetworkClientProtocol> {
        self {
            let url = URL(string: "https://p2pb2b.com/")!
            return DefaultNetworkClient(baseURL: url)
        }
    }
    
    var webSocketClient: Factory<WebSocketClientProtocol> {
        self {
            let url = URL(string: "wss://ws.p2pb2b.com/ws")!
            return DefaultWebSocketClient(url: url)
        }
    }
    
    var marketService: Factory<MarketServiceProtocol> {
        self {
            DefaultMarketService(
                networkClient: self.networkClient(),
                webSocketClient: self.webSocketClient()
            )
        }
    }
}
