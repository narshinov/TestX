import Foundation

final class RandomPhotosRequestService {
    
    func fetchRandomPhotosMock() async throws -> [UnsplashPhoto] {
        var result: [UnsplashPhoto] = []
        (0..<30).forEach { _ in
            var mock = UnsplashPhoto.mock
            mock = UnsplashPhoto(
                id: UUID().uuidString,
                description: mock.description,
                urls: mock.urls,
                user: mock.user
            )
            result.append(mock)
        }
        return result
    }
    
    func fetchRandomPhotos() async throws -> [UnsplashPhoto] {
        do {
//            throw NetworkError.badRequest
            let urlRequest = try buildRequest()
            let result = try await requestRandomPhotos(with: urlRequest)
            return result
        } catch {
            throw error
        }
    }
    private func buildRequest() throws -> URLRequest {
        let apiPath = "/photos/random"
        
        var components = URLComponents(string: Constants.API.baseURL + apiPath)
        components?.queryItems = [URLQueryItem(name: "count", value: "30")]
        
        guard let url = components?.url else { throw NetworkError.badURL  }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Client-ID \(Constants.API.accessKey)", forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
    
    private func requestRandomPhotos(with request: URLRequest) async throws -> [UnsplashPhoto] {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            let decodedResult = try decodeResponse(data: data)
            return decodedResult
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
    
    private func decodeResponse(data: Data) throws -> [UnsplashPhoto] {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode([UnsplashPhoto].self, from: data)
            print("Successfully decoded response")
            return result
        } catch {
            print("Error: \(error)")
            throw NetworkError.responseDecodingError
        }
    }
}
