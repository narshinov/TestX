import Foundation

final class SearchPhotoRequestService {
    func searchPhotos(query: String, page: Int = 1, perPage: Int = 30) async throws -> [UnsplashPhoto] {
        do {
            let urlRequest = try buildRequest(query: query, page: page, perPage: perPage)
            let result = try await requestSearchPhotos(with: urlRequest)
            return result
        } catch {
            throw error
        }
    }
    
    private func buildRequest(query: String, page: Int, perPage: Int) throws -> URLRequest {
        let apiPath = "/search/photos"
        
        var components = URLComponents(string: Constants.API.baseURL + apiPath)
        components?.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(perPage)"),
            URLQueryItem(name: "order_by", value: "relevant")
        ]
        
        guard let url = components?.url else { throw NetworkError.badURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Client-ID \(Constants.API.accessKey)", forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
    
    private func requestSearchPhotos(with request: URLRequest) async throws -> [UnsplashPhoto] {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            let decodedResult = try decodeResponse(data: data)
            return decodedResult.results
        case 400:
            throw NetworkError.badRequest
        case 401:
            throw NetworkError.unauthorized
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        default:
            throw NetworkError.badServerResponse
        }
    }
    
    private func decodeResponse(data: Data) throws -> SearchPhotosResponse {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(SearchPhotosResponse.self, from: data)
            print("Successfully decoded search response")
            return result
        } catch {
            print("Decoding error:", error)
            throw NetworkError.responseDecodingError
        }
    }
}


struct SearchPhotosResponse: Decodable {
    let total: Int
    let totalPages: Int
    let results: [UnsplashPhoto]
}
