import SwiftUI
import SwiftData

struct CoreView: View {
    let modelContainer: ModelContainer
    
    var body: some View {
        TabView {
            PhotosView(modelContainer: modelContainer)
            .tabItem {
                Label("Photos", systemImage: "photo.stack")
            }
            
            FavoritesView(modelContainer: modelContainer)
            .tabItem {
                Label("Favorites", systemImage: "heart")
            }
        }
    }
}
