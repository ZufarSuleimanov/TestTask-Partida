import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed(Error)
}
