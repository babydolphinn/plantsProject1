
import SwiftUI

struct PlantRow: View {

    let plant: Plant

    let onToggle: () -> Void
    let onEdit: () -> Void

    private var isWateredToday: Bool {
        guard let lastWatered = plant.lastWateredAt else {
            return false
        }

        return Calendar.current.isDateInToday(
            lastWatered
        )
    }

    var body: some View {

        HStack(
            alignment: .top,
            spacing: AppSpacing.screenPadding
        ) {

            // MARK: - Watering Checkbox
            Button(action: onToggle) {

                ZStack {

                    if isWateredToday {

                        Circle()
                            .fill(Color("MintAccent"))

                        Image(systemName: "checkmark")
                            .font(
                                .system(
                                    size: 13,
                                    weight: .semibold
                                )
                            )
                            .foregroundStyle(
                                Color("Background")
                            )

                    } else {

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
            .accessibilityLabel(
                "Toggle watering for \(plant.name)"
            )

            // MARK: - Plant Details
            VStack(alignment: .leading) {

                Text("in \(plant.room.rawValue)")
                    .font(AppTypography.tag)
                    .foregroundStyle(
                        Color("SecondaryText")
                    )

                Text(plant.name)
                    .font(AppTypography.plantName)
                    .foregroundStyle(.white)

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
            .opacity(isWateredToday ? 0.4 : 1.0)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .contentShape(Rectangle())
            .onTapGesture {
                onEdit()
            }

            Spacer(minLength: 0)
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

