import SwiftData
import SwiftUI

struct SetReminderView: View {

    // Gives this view access to the SwiftData database
    @Environment(\.modelContext) private var modelContext
    // Reuse the ViewModel we already created
    private let viewModel = PlantViewModel()
    @Environment(\.dismiss) private var dismiss

    // Form values
    @State private var plantName = ""
    @State private var room: Room = .bedroom
    @State private var light: Light = .fullSun
    @State private var wateringDays: WateringDays = .everyDay
    @State private var water: Water = .small

    var body: some View {
        VStack(spacing: 0) {

            // Top bar
            HStack {
                GlassCircleButton(
                    symbol: "xmark",
                    isProminent: false,
                    action: { dismiss() }
                )

                Spacer()

                Text("Set Reminder")
                    .font(AppTypography.formLabel)
                    .foregroundStyle(.white)

                Spacer()

                GlassCircleButton(
                    symbol: "checkmark",
                    isProminent: true,
                    action: {
                        savePlant()
                    }
                )
            }
            .padding(.horizontal, AppSpacing.screenPadding)

            // Form cards
            VStack(spacing: 40) {

                FormCard {
                    HStack {
                        Text("Plant Name")
                            .font(AppTypography.formLabel)
                            .foregroundStyle(.white)

                        TextField("Pothos", text: $plantName)
                            .font(AppTypography.formLabel)
                            .foregroundStyle(.white)
                            .tint(Color("MintAccent"))
                            .multilineTextAlignment(.trailing)
                    }
                    .padding(AppSpacing.screenPadding)
                }

                FormCard {
                    VStack(spacing: 0) {
                        PickerRow(
                            title: "Room",
                            symbol: "location",
                            options: Array(Room.allCases),
                            selection: $room
                        )

                        Rectangle()
                            .fill(Color("CardDivider"))
                            .frame(height: 1)

                        PickerRow(
                            title: "Light",
                            symbol: "sun.max",
                            options: Array(Light.allCases),
                            selection: $light
                        )
                    }
                }

                FormCard {
                    VStack(spacing: 0) {
                        PickerRow(
                            title: "Watering Days",
                            symbol: "drop",
                            options: Array(WateringDays.allCases),
                            selection: $wateringDays
                        )

                        Rectangle()
                            .fill(Color("CardDivider"))
                            .frame(height: 1)

                        PickerRow(
                            title: "Water",
                            symbol: "drop",
                            options: Array(Water.allCases),
                            selection: $water
                        )
                    }
                }
            }
            .padding(.horizontal, AppSpacing.screenPadding)
            .padding(.top, 55)

            Spacer()
        }
        .padding(.top, AppSpacing.screenPadding)
        .background(Color("SheetBackground"))
        .preferredColorScheme(.dark)
    }
    
    private func savePlant() {

        // Remove extra spaces from the plant name
        let name = plantName.trimmingCharacters(in: .whitespacesAndNewlines)

        // Don't save plants without a name
        guard !name.isEmpty else { return }

        // Ask our ViewModel to create and insert the plant
        viewModel.addPlant(
            name: name,
            room: room,
            light: light,
            wateringDays: wateringDays,
            water: water,
            context: modelContext
        )

        // Close the sheet after saving
        dismiss()
    }

}

