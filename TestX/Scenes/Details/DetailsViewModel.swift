import SwiftData

@Observable
final class DetailsViewModel {
    var photo: UnsplashPhoto
    
    var isFavorite: Bool = false
    
    private let dataManager: DataManager
    
    init(
        modelContainer: ModelContainer,
        photo: UnsplashPhoto
    ) {
        self.photo = photo
        self.dataManager = DataManager(modelContainer: modelContainer)
    }
    
    func onAppear() async {
        isFavorite = await dataManager.isPhotoSaved(photo.id)
    }

    func toggleFavorite() {
        isFavorite.toggle()
        Task { [isFavorite, photo] in
            if isFavorite {
                await dataManager.insertPhoto(photo)
            } else {
                await dataManager.removePhoto(photo.id)
            }
        }
    }
}
