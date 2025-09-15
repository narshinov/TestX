import SwiftUI
import SwiftData
import Kingfisher

struct DetailsView: View {
    @Environment(\.dismiss) var dismiss
    @State var viewModel: DetailsViewModel

    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: viewModel.photo.urls.regular))
                .placeholder { ImagePlaceholder() }
                .onFailureView { ImageFailureView() }
                .resizable()
                .scaledToFit()
            
            infoView
        }
        .overlay(alignment: .topTrailing) {
            closeButton
                .padding([.top, .trailing])
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .task {
            await viewModel.onAppear()
        }
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
            Spacer()
            Button(action: viewModel.toggleFavorite) {
                Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.red)
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal)
    }
}
