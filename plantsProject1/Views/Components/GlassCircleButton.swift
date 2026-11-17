
import SwiftUI

struct GlassCircleButton: View {

    let symbol: String
    let isProminent: Bool
    let action: () -> Void

    var body: some View {
        Group {
            if isProminent {
                Button(action: action) {
                    buttonLabel
                }
                .buttonStyle(.glassProminent)
                .tint(AppColors.brandGreen)
            } else {
                Button(action: action) {
                    buttonLabel
                }
                .buttonStyle(.glass)
            }
        }
        .buttonBorderShape(.circle)
        .accessibilityLabel(symbol)
    }

    private var buttonLabel: some View {
        Image(systemName: symbol)
            .font(AppTypography.headline)
            .foregroundStyle(AppColors.primaryText)
            .frame(width: 44, height: 44)
            .contentShape(Circle())
    }
}

