import Foundation

@Observable
final class PhotosViewModel {
    
    var photos: [UnsplashPhoto] = []
    var errorMessage: String?
    
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
    
    func fetchRandomPhotos() async {
        await searchOrLoadRandomPhotos()
    }
    
    func retryRequest() {
        Task {
            errorMessage = nil
            await searchOrLoadRandomPhotos()
        }
    }
    
    private func searchOrLoadRandomPhotos() async {
        do {
            if searchText.isEmpty {
                guard !isLoaded else { return }
                photos = try await randomPhotosRequestService.fetchRandomPhotos()
                isLoaded = true
            } else {
                photos = try await searchPhotoRequestService.searchPhotos(query: searchText)
            }
            
            errorMessage = nil
        } catch {
            photos = []
            await MainActor.run {
                let networkError = error as? NetworkError
                errorMessage = networkError?.message ?? "Something went wrong"
            }
        }
    }
}
