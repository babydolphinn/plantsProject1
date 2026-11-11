
import SwiftUI

struct PlantRow: View {

    // The plant displayed in this reminder row
    let plant: Plant

    var body: some View {
        HStack(alignment: .top, spacing: AppSpacing.screenPadding) {

            // Unchecked reminder indicator
            Circle()
                .strokeBorder(Color("CheckboxRing"), lineWidth: 1.2)
                .frame(width: 23, height: 23)

            VStack(alignment: .leading) {

                // Room label
                Text("in \(plant.room.rawValue)")
                    .font(AppTypography.tag)
                    .foregroundStyle(Color("SecondaryText"))

                // Plant name
                Text(plant.name)
                    .font(AppTypography.plantName)
                    .foregroundStyle(Color.primary)

               
                HStack(spacing: 13) {

                    TagPill(
                        title: plant.light.rawValue,
                        symbol: "sun.max",
                        colorName: "SunTag"
                    )

                    TagPill(
                        title: plant.water.rawValue,
                        symbol: "drop",
                        colorName: "WaterTag"
                    )
                }
                .padding(.top, AppSpacing.pillRadius)

            }

            Spacer()
        }
        .frame(
            maxWidth: .infinity,
            minHeight: AppSpacing.rowHeight,
            alignment: .leading
        )
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color("RowDivider"))
                .frame(height: 1)
        }
    }
}

