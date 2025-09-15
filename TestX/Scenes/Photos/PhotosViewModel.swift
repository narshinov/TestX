import Foundation

@Observable
final class PhotosViewModel {
    
    var photos: [UnsplashPhoto] = []
    
    var searchText: String = "" {
        didSet {
            Task {
                await searchOrLoadRandomPhotos()
            }
        }
    }
    
    private var isLoaded = false
    
    private let randomPhotosRequestService = RandomPhotosRequestService()
    private let searchPhotoRequestService = SearchPhotoRequestService()
    
    func searchOrLoadRandomPhotos() async {
        do {
            if searchText.isEmpty {
                guard !isLoaded else { return }
                photos = try await randomPhotosRequestService.fetchRandomPhotosMock()
                isLoaded = true
            } else {
                photos = try await searchPhotoRequestService.searchPhotos(query: searchText)
            }
        } catch {
            print("Error loading photos:", error)
            photos = []
        }
    }
    
    func fetchRandomPhotos() async {
        await searchOrLoadRandomPhotos()
    }
}
