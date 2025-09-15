import Foundation

@Observable
final class DetailsViewModel {
    var photo: UnsplashPhoto
    
    init(photo: UnsplashPhoto) {
        self.photo = photo
    }
    
    func addToFavorite() {
        
    }
}
