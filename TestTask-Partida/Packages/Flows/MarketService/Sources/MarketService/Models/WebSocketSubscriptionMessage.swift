import Foundation

struct WebSocketSubscriptionMessage: Encodable {
    let method: String
    let params: [String]
    let id: Int
}
