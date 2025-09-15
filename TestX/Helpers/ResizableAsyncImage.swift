import SwiftUI

struct ResizableAsyncImage: View {
    let url: URL
    let contentMode: ContentMode
    
    init(
        url: URL,
        contentMode: ContentMode = .fill
    ) {
        self.url = url
        self.contentMode = contentMode
    }
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                Rectangle()
                    .fill(.background.secondary)
                    .overlay {
                        ProgressView()
                    }
                
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                
            case .failure:
                Rectangle()
                    .fill(.background.secondary)
                    .overlay {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundStyle(.red)
                            .padding(32)
                    }
                
            @unknown default:
                EmptyView()
            }
        }
    }
}
