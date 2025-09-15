import SwiftData

@Model
final class PhotoEntry {
    @Attribute(.unique) var id: String
    var photoDescription: String?
    var rawUrl: String
    var fullUrl: String
    var regularUrl: String
    var smallUrl: String
    var thumbUrl: String
    @Attribute(.unique) var userID: String
    var username: String
    var name: String
    
    init(id: String,
         photoDescription: String?,
         rawUrl: String,
         fullUrl: String,
         regularUrl: String,
         smallUrl: String,
         thumbUrl: String,
         userID: String,
         username: String,
         name: String) {
        
        self.id = id
        self.photoDescription = photoDescription
        self.rawUrl = rawUrl
        self.fullUrl = fullUrl
        self.regularUrl = regularUrl
        self.smallUrl = smallUrl
        self.thumbUrl = thumbUrl
        self.userID = userID
        self.username = username
        self.name = name
    }
}

extension PhotoEntry {
    convenience init(from dto: UnsplashPhoto) {
        self.init(
            id: dto.id,
            photoDescription: dto.description,
            rawUrl: dto.urls.raw,
            fullUrl: dto.urls.full,
            regularUrl: dto.urls.regular,
            smallUrl: dto.urls.small,
            thumbUrl: dto.urls.thumb,
            userID: dto.user.id,
            username: dto.user.username,
            name: dto.user.name
        )
    }
}
