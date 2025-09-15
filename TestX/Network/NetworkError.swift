import Foundation

enum NetworkError: Error {
    case badURL
    case invalidResponse
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case unknown
    case badServerResponse
    case responseDecodingError
}
