
import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext

    @Query private var plants: [Plant]

    @State private var showingSetReminder = false

    private let viewModel = PlantViewModel()

    // Count how many plants were watered today
    private var completedCount: Int {
        plants.filter { plant in
            guard let lastWatered = plant.lastWateredAt else {
                return false
            }

            return Calendar.current.isDateInToday(lastWatered)
        }.count
    }

    // Convert completed plants into a progress value from 0 to 1
    private var wateringProgress: Double {
        guard !plants.isEmpty else { return 0 }

        return Double(completedCount) / Double(plants.count)
    }

    var body: some View {

        ZStack {

            // Background color from Assets
            Color("Background")
                .ignoresSafeArea()

            VStack {

                // MARK: - Header
                VStack(alignment: .leading, spacing: 0) {

                    Text("My Plants 🌱")
                        .font(AppTypography.screenTitle)
                        .foregroundStyle(.white)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding(
                            .horizontal,
                            AppSpacing.screenPadding
                        )
                        .padding(
                            .bottom,
                            AppSpacing.screenPadding
                        )

                    Rectangle()
                        .fill(Color("HeaderDivider"))
                        .frame(height: 1)
                        .padding(
                            .horizontal,
                            AppSpacing.screenPadding
                        )
                }

                // MARK: - Progress Section
                // Hide progress when all plants are completed
                if plants.isEmpty || completedCount < plants.count {

                    VStack(spacing: 15) {

                        Text(
                            completedCount == 0
                                ? "Your plants are waiting for a sip 💦"
                                : "\(completedCount) of \(plants.count) plants watered today 💦"
                        )
                        .font(AppTypography.formLabel)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)

                        AnimatedProgressBar(
                            progress: wateringProgress
                        )
                    }
                    .padding(
                        .horizontal,
                        AppSpacing.screenPadding
                    )
                    .padding(.top, 38)
                }

                // MARK: - Completed Screen or Plant List
                if !plants.isEmpty && completedCount == plants.count {

                    // Show the Sketch-inspired All Done screen
                    AllRemindersCompletedView()

                } else {

                    List(plants) { plant in

                        PlantRow(plant: plant) {

                            withAnimation {
                                viewModel.toggleWatered(
                                    plant: plant
                                )
                            }
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(
                            Color("Background")
                        )
                        .listRowSeparator(.hidden)
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color("Background"))
                }
            }

            // MARK: - Floating Add Button
            VStack {

                Spacer()

                HStack {

                    Spacer()

                    GlassCircleButton(
                        symbol: "plus",
                        isProminent: true,
                        action: {
                            showingSetReminder = true
                        }
                    )
                }
                .padding(.trailing, 30)
                .padding(.bottom, 41)
            }
        }
        .preferredColorScheme(.dark)

        // MARK: - Set Reminder Sheet
        .sheet(isPresented: $showingSetReminder) {

            SetReminderView()
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(
                    AppSpacing.sheetRadius
                )
                .presentationBackground(
                    Color("SheetBackground")
                )
        }
    }
}

#Preview {
    ContentView()
}

