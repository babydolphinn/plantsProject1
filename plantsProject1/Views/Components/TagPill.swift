
import SwiftUI

struct TagPill: View {

    // Text and symbol displayed inside the tag
    let title: String
    let symbol: String

    // Use an existing color from Assets
    let colorName: String

    var body: some View {
        Label(title, systemImage: symbol)
            .font(AppTypography.tag)
            .foregroundStyle(Color(colorName))
            .padding(.horizontal, AppSpacing.pillRadius)
            .frame(height: 23)
            .background(Color("PillBackground"))
            .clipShape(
                RoundedRectangle(cornerRadius: AppSpacing.pillRadius)
            )
    }
}

