import Foundation

struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let description: String?
    let urls: Urls
    let user: User
    
    struct Urls: Codable {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
    }
    
    struct User: Codable {
        let id: String
        let username: String
        let name: String
    }
}

extension UnsplashPhoto {
    static var mock = UnsplashPhoto(
        id: UUID().uuidString,
        description: "dsdskmcmksdkmcmkdskdskmckmdsckmds",
        urls: .init(
            raw: "https://img.freepik.com/free-photo/closeup-scarlet-macaw-from-side-view-scarlet-macaw-closeup-head_488145-3540.jpg?semt=ais_incoming&w=740&q=80",
            full: "https://img.freepik.com/free-photo/closeup-scarlet-macaw-from-side-view-scarlet-macaw-closeup-head_488145-3540.jpg?semt=ais_incoming&w=740&q=80",
            regular: "https://img.freepik.com/free-photo/closeup-scarlet-macaw-from-side-view-scarlet-macaw-closeup-head_488145-3540.jpg?semt=ais_incoming&w=740&q=80",
            small: "https://img.freepik.com/free-photo/closeup-scarlet-macaw-from-side-view-scarlet-macaw-closeup-head_488145-3540.jpg?semt=ais_incoming&w=740&q=80",
            thumb: "https://img.freepik.com/free-photo/closeup-scarlet-macaw-from-side-view-scarlet-macaw-closeup-head_488145-3540.jpg?semt=ais_incoming&w=740&q=80"
        ),
        user: .init(
            id: UUID().uuidString,
            username: "Bob22",
            name: "Bob"
        )
    )
    
    init(from entry: PhotoEntry) {
        self.id = entry.id
        self.description = entry.photoDescription
        self.urls = Urls(
            raw: entry.rawUrl,
            full: entry.fullUrl,
            regular: entry.regularUrl,
            small: entry.smallUrl,
            thumb: entry.thumbUrl
        )
        self.user = User(
            id: entry.userID,
            username: entry.username,
            name: entry.name
        )
    }
}
