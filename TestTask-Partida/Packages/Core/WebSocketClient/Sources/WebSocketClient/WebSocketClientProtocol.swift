import Foundation

public protocol WebSocketClientProtocol {
    func connect() async throws
    func disconnect()
    func send<T: Encodable>(_ message: T) async throws
    func receive<T: Decodable>() async throws -> T
    var isConnected: Bool { get }
}
