import SwiftUI

struct ImagePlaceholder: View {
    var body: some View {
        Rectangle()
            .fill(.background.secondary)
            .overlay {
                ProgressView()
            }
    }
}
