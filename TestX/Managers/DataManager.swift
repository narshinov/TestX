import SwiftData
import SwiftUI

@ModelActor
final actor DataManager: ModelActor {
    
    func insertPhoto(_ entry: UnsplashPhoto) {
        let photo = PhotoEntry(from: entry)
        modelContext.insert(photo)
        saveContext()
    }
    
    func removePhoto(_ id: String) {
        let predicate = #Predicate<PhotoEntry> { $0.id == id }
        let descriptor = FetchDescriptor<PhotoEntry>(predicate: predicate)
        
        do {
            let results = try modelContext.fetch(descriptor)
            results.forEach {
                modelContext.delete($0)
            }
            saveContext()
        } catch {
            print("Failed to delete photo: \(error)")
            assertionFailure()
        }
    }
    
    func fetchAllPhotos() -> [UnsplashPhoto] {
        let descriptor = FetchDescriptor<PhotoEntry>(sortBy: [])
        
        do {
            return try modelContext.fetch(descriptor).map { UnsplashPhoto(from: $0) }
        } catch {
            print("Failed to fetch photos: \(error)")
            return []
        }
    }
        
    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save data to SwiftData: \(error)")
            assertionFailure()
        }
    }
}
