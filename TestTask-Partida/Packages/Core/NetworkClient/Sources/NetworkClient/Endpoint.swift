import Foundation

public struct Endpoint {
    public let path: String
    public let queryItems: [URLQueryItem]?

    public init(
        path: String,
        queryItems: [URLQueryItem]? = nil
    ) {
        self.path = path
        self.queryItems = queryItems
    }
}
