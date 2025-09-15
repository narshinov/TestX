import SwiftUI
import SwiftData

struct PhotosView: View {
    
    let modelContainer: ModelContainer
    
    @State private var viewModel: PhotosViewModel = PhotosViewModel()
    
    private let spacing: CGFloat = 10
    private let horizontalPadding: CGFloat = 22
    private let columns = 3
    
    @State private var selectedPhoto: UnsplashPhoto?
    
    var body: some View {
        NavigationStack {
            imageGrid
                .searchable(
                    text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search photos"
                )
                .task {
                    await viewModel.fetchRandomPhotos()
                }
                .sheet(item: $selectedPhoto) { photo in
                    DetailsView(
                        viewModel: .init(modelContainer: modelContainer, photo: photo)
                    )
                }
        }
    }
    
    private var imageGrid: some View {
        GeometryReader { geometry in
            let itemWidth = calculateItemWidth(for: geometry.size.width)
            
            ScrollView {
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(.flexible(), spacing: spacing),
                        count: 3
                    ),
                    spacing: spacing
                ) {
                    ForEach(viewModel.photos) { photo in
                        if let url = URL(string: photo.urls.small) {
                            ResizableAsyncImage(
                                url: url
                            )
                            .frame(width: itemWidth, height: itemWidth)
                            .cornerRadius(16)
                            .onTapGesture {
                                selectedPhoto = photo
                            }
                        }
                    }
                }
                .padding(.horizontal, horizontalPadding)
            }
        }
    }
    
    private func calculateItemWidth(for totalWidth: CGFloat) -> CGFloat {
        let totalSpacing = spacing * CGFloat(columns - 1)
        let availableWidth = totalWidth - horizontalPadding * 2 - totalSpacing
        return availableWidth / CGFloat(columns)
    }
}
