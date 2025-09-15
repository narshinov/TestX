import SwiftUI
import SwiftData
import Kingfisher

struct FavoritesView: View {
    
    let modelContainer: ModelContainer
    
    @Query private var photoEntries: [PhotoEntry]
    @State private var selectedPhoto: UnsplashPhoto?
    
    var body: some View {
        List(photoEntries) { entry in
            listCell(UnsplashPhoto(from: entry))
        }
        .sheet(item: $selectedPhoto) { photo in
            DetailsView(
                viewModel: .init(modelContainer: modelContainer, photo: photo)
            )
        }
    }
    
    private func listCell(_ photo: UnsplashPhoto) -> some View  {
        Button {
             selectedPhoto = photo
         } label: {
             HStack {
                 if let url = URL(string: photo.urls.thumb) {
                     KFImage(url)
                         .placeholder { ImagePlaceholder() }
                         .onFailureView { ImageFailureView() }
                         .resizable()
                         .scaledToFill()
                         .frame(width: 60, height: 60)
                         .cornerRadius(8)
                 }
                 Text(photo.user.name)
                     .fontWeight(.semibold)
                 Spacer()
             }
             .contentShape(Rectangle())
         }
         .buttonStyle(.plain)
    }
}
