import SwiftData

@Observable
final class FavoritesViewModel {
    var photos: [UnsplashPhoto] = []
    private let dataManager: DataManager
    
    init(modelContainer: ModelContainer) {
        self.dataManager = DataManager(modelContainer: modelContainer)
    }
    
    func loadFavorites() async {
        let items = await dataManager.fetchAllPhotos()
        await MainActor.run {
            self.photos = items
        }
    }
}


