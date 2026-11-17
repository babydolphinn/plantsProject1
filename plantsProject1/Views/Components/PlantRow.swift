
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
                            .fill(AppColors.mintAccent)

                        Image(systemName: "checkmark")
                            .font(
                                .system(
                                    size: 13,
                                    weight: .semibold
                                )
                            )
                            .foregroundStyle(
                                AppColors.background
                            )

                    } else {

                        Circle()
                            .strokeBorder(
                                AppColors.checkboxRing,
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
                        AppColors.secondaryText
                    )

                Text(plant.name)
                    .font(AppTypography.plantName)
                    .foregroundStyle(AppColors.primaryText)

                HStack(spacing: 13) {

                    TagPill(
                        title: plant.light.rawValue,
                        symbol: plant.light.symbol,
                        color: AppColors.sunTag
                    )

                    TagPill(
                        title: plant.water.rawValue,
                        symbol: "drop",
                        color: AppColors.waterTag
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
                .fill(AppColors.rowDivider)
                .frame(height: 1)
        }
    }
}

