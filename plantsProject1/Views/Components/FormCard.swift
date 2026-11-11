
import SwiftUI

struct FormCard<Content: View>: View {

    // The UI placed inside this card
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            content()
        }
        .background(Color("CardBackground"))
        .clipShape(
            RoundedRectangle(
                cornerRadius: AppSpacing.cardRadius
            )
        )
    }
}

