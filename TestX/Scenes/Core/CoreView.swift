import SwiftUI

struct CoreView: View {
    var body: some View {
        TabView {
            PhotosView(viewModel: PhotosViewModel())
                .tabItem {
                    Label("Photos", systemImage: "photo.stack")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}

#Preview {
    CoreView()
}
