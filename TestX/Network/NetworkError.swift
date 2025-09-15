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

extension NetworkError: LocalizedError {
    var message: String? {
        switch self {
        case .badURL: "The URL is invalid."
        case .invalidResponse: "Received an invalid response from the server."
        case .badRequest: "The request was incorrect or missing required parameters."
        case .unauthorized: "You are not authorized. Please check your access token."
        case .forbidden: "You do not have permission to perform this action."
        case .notFound: "The requested resource was not found."
        case .unknown: "An unknown error occurred."
        case .badServerResponse: "The server returned an error. Please try again later."
        case .responseDecodingError: "Failed to process the server response."
        }
    }
}
