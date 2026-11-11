
import SwiftUI

struct PlantRow: View {

    // The plant displayed in this reminder row
    let plant: Plant
    let onToggle: () -> Void
    private var isWateredToday: Bool {
        guard let lastWatered = plant.lastWateredAt else {
            return false
        }

        return Calendar.current.isDateInToday(lastWatered)
    }
    var body: some View {
        HStack(alignment: .top, spacing: AppSpacing.screenPadding) {

            // check reminder button
            Button(action: onToggle) {
                ZStack {

                    if let lastWatered = plant.lastWateredAt,
                       Calendar.current.isDateInToday(lastWatered) {

                        // Completed: solid mint circle with dark checkmark
                        Circle()
                            .fill(Color("MintAccent"))

                        Image(systemName: "checkmark")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color("Background"))

                    } else {

                        // Not completed: outlined circle
                        Circle()
                            .strokeBorder(
                                Color("CheckboxRing"),
                                lineWidth: 1.2
                            )
                    }
                }
                .frame(width: 23, height: 23)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Toggle watering for \(plant.name)")



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

            }.opacity(isWateredToday ? 0.4 : 1.0) //faded appearance,

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

