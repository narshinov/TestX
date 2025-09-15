import SwiftUI
import SwiftData

struct DetailsView: View {
    @Environment(\.dismiss) var dismiss
    var viewModel: DetailsViewModel

    var body: some View {
        VStack(alignment: .leading) {
            imageView
            infoView
        }
        .overlay(alignment: .topTrailing) {
            closeButton
                .padding([.top, .trailing])
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 32, height: 32)
        }
    }
    
    @ViewBuilder
    private var imageView: some View {
        if let url = URL(string: viewModel.photo.urls.regular) {
            ResizableAsyncImage(
                url: url,
                contentMode: .fit
            )
        }
    }
    
    private var infoView: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading) {
                if let description = viewModel.photo.description {
                    Text(description)
                        .font(.system(size: 20))
                }
                Text("@\(viewModel.photo.user.username)")
                    .fontWeight(.bold)
            }
            
            Button(action: viewModel.addToFavorite) {
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.red)
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal)
    }
}
