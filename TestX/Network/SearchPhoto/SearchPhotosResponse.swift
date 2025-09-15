import Foundation

struct SearchPhotosResponse: Decodable {
    let total: Int
    let totalPages: Int
    let results: [UnsplashPhoto]
}
