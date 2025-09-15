import SwiftData

@Observable
final class DetailsViewModel {
    var photo: UnsplashPhoto
    
    private let dataManager: DataManager
    
    init(modelContainer: ModelContainer, photo: UnsplashPhoto) {
        self.photo = photo
        self.dataManager = DataManager(modelContainer: modelContainer)
    }
    
    func addToFavorite() {
        Task { [photo] in
            await dataManager.insertPhoto(photo)
        }
    }
}
