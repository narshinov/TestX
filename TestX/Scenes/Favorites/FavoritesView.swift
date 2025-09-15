import SwiftUI

struct FavoritesView: View {
    @State var viewModel: FavoritesViewModel
    
    var body: some View {
        List(viewModel.photos) { photo in
            HStack {
                if let url = URL(string: photo.urls.thumb) {
                    ResizableAsyncImage(url: url)
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                }
                VStack(alignment: .leading) {
                    Text(photo.user.name)
                        .fontWeight(.semibold)
                    if let description = photo.description {
                        Text(description)
                            .lineLimit(2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .task {
            await viewModel.loadFavorites()
        }
        .navigationTitle("Favorites")
    }
}
