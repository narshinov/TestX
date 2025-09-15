import SwiftUI

struct ImageFailureView: View {
    var body: some View {
        Rectangle()
            .fill(.background.secondary)
            .overlay {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .foregroundStyle(.red)
                    .padding(32)
            }
    }
}
