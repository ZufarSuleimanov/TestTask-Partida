import Foundation

public final class DefaultWebSocketClient: WebSocketClientProtocol {
    private let url: URL
    private var task: URLSessionWebSocketTask?
    private let session: URLSession
    private(set) public var isConnected: Bool = false

    public init(
        url: URL,
        session: URLSession = .shared
    ) {
        self.url = url
        self.session = session
    }

    public func connect() async throws {
        guard task == nil else { return }

        task = session.webSocketTask(with: url)
        task?.resume()
        isConnected = true
    }

    public func disconnect() {
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
        isConnected = false
    }

    public func send<T: Encodable>(_ message: T) async throws {
        let data = try JSONEncoder().encode(message)
        let string = String(data: data, encoding: .utf8) ?? ""
        try await task?.send(.string(string))
    }

    public func receive<T: Decodable>() async throws -> T {
        guard isConnected else {
            print("⚠️ WebSocket не подключён")
            throw WebSocketError.notConnected
        }
        
        guard let task else { throw WebSocketError.notConnected }

        let message = try await task.receive()

        switch message {
        case let .string(string):
            guard
                let data = string.data(using: .utf8)
            else {
                throw WebSocketError.invalidData
            }
            return try JSONDecoder().decode(T.self, from: data)

        case let .data(data):
            return try JSONDecoder().decode(T.self, from: data)

        @unknown default:
            throw WebSocketError.unknown
        }
    }
}
