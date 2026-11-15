
import SwiftData
import SwiftUI

struct SetReminderView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    private let viewModel = PlantViewModel()

    // nil means we're adding a new plant.
    // An existing plant means we're editing it.
    let plant: Plant?

    @State private var plantName: String
    @State private var room: Room
    @State private var light: Light
    @State private var wateringDays: WateringDays
    @State private var water: Water

    // Fill the form automatically when editing
    init(plant: Plant? = nil) {
        self.plant = plant

        _plantName = State(
            initialValue: plant?.name ?? ""
        )
        _room = State(
            initialValue: plant?.room ?? .bedroom
        )
        _light = State(
            initialValue: plant?.light ?? .fullSun
        )
        _wateringDays = State(
            initialValue: plant?.wateringDays ?? .everyDay
        )
        _water = State(
            initialValue: plant?.water ?? .small
        )
    }

    var body: some View {

        VStack(spacing: 0) {

            // MARK: - Top Bar
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
            .padding(
                .horizontal,
                AppSpacing.screenPadding
            )

            // MARK: - Form
            VStack(spacing: 40) {

                // Plant Name
                FormCard {

                    HStack {

                        Text("Plant Name")
                            .font(AppTypography.formLabel)
                            .foregroundStyle(.white)

                        TextField(
                            "Pothos",
                            text: $plantName
                        )
                        .font(AppTypography.formLabel)
                        .foregroundStyle(.white)
                        .tint(Color("MintAccent"))
                        .multilineTextAlignment(.trailing)
                    }
                    .padding(AppSpacing.screenPadding)
                }

                // Room and Light
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
                            symbol: light.symbol,
                            options: Array(Light.allCases),
                            selection: $light
                        )
                    }
                }

                // Watering Days and Water
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

                // MARK: - Delete Reminder
                // Only appears when editing an existing plant
                if plant != nil {

                    FormCard {

                        Button {
                            deletePlant()
                        } label: {

                            Text("Delete Reminder")
                                .font(AppTypography.formLabel)
                                .foregroundStyle(
                                    Color("DestructiveRed")
                                )
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(
                .horizontal,
                AppSpacing.screenPadding
            )
            .padding(.top, 55)

            Spacer()
        }
        .padding(.top, AppSpacing.screenPadding)
        .background(Color("SheetBackground"))
        .preferredColorScheme(.dark)
    }

    // MARK: - Save
    private func savePlant() {

        let name = plantName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !name.isEmpty else { return }

        if let plant {

            // Edit the existing plant
            viewModel.updatePlant(
                plant,
                name: name,
                room: room,
                light: light,
                wateringDays: wateringDays,
                water: water
            )

        } else {

            // Create a new plant
            viewModel.addPlant(
                name: name,
                room: room,
                light: light,
                wateringDays: wateringDays,
                water: water,
                context: modelContext
            )
        }

        // Update notifications after adding or editing.
        // Only new plants trigger the permission request.
        Task {
            await NotificationManager.shared.synchronize(
                context: modelContext,
                askPermission: plant == nil
            )
        }

        dismiss()
    }

    // MARK: - Delete
    private func deletePlant() {

        guard let plant else { return }

        viewModel.deletePlant(
            plant,
            context: modelContext
        )

        // Cancel deleted plant's reminders
        // and update the remaining schedules.
        Task {
            await NotificationManager.shared.synchronize(
                context: modelContext
            )
        }

        dismiss()
    }
}

