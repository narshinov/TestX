import Foundation

@Observable
final class PhotosViewModel {
    
    var photos: [UnsplashPhoto] = []
    var errorMessage: String?
    
    var searchText: String = "" {
        didSet {
            searchTask?.cancel()
            searchTask = Task {
                try? await Task.sleep(nanoseconds: 300_000_000)
                guard !Task.isCancelled else { return }
                await searchOrLoadRandomPhotos()
            }
        }
    }
    
    private var searchTask: Task<Void, Never>?
        
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
        let currentQuery = searchText

        do {
            let result: [UnsplashPhoto]

            if searchText.isEmpty {
                guard !isLoaded else { return }
                result = try await randomPhotosRequestService.fetchRandomPhotos()
                isLoaded = true
            } else {
                result = try await searchPhotoRequestService.searchPhotos(query: searchText)
            }
            
            errorMessage = nil

            guard currentQuery == searchText else { return }
            photos = result
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {
                return
            }
            photos = []
            await MainActor.run {
                let networkError = error as? NetworkError
                errorMessage = networkError?.message ?? "Something went wrong"
            }
        }
    }
}
