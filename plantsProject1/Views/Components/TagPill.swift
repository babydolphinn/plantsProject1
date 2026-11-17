
import SwiftUI

struct TagPill: View {

    // Text and symbol displayed inside the tag
    let title: String
    let symbol: String

    // Theme color supplied by the caller
    let color: Color

    var body: some View {
        Label(title, systemImage: symbol)
            .font(AppTypography.tag)
            .foregroundStyle(color)
            .padding(.horizontal, AppSpacing.pillRadius)
            .frame(height: 23)
            .background(AppColors.pillBackground)
            .clipShape(
                RoundedRectangle(cornerRadius: AppSpacing.pillRadius)
            )
    }
}

