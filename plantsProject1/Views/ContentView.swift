
import SwiftUI
import SwiftData

struct ContentView: View {

    @Query private var plants: [Plant]

    @State private var showingSetReminder = false

    private let viewModel = PlantViewModel()

    // Only plants with a reminder due today
    private var todayPlants: [Plant] {
        plants.filter { plant in
            viewModel.isDueToday(plant)
        }
    }

    // Count today's completed reminders
    private var completedCount: Int {
        todayPlants.filter { plant in
            viewModel.isWateredToday(plant)
        }.count
    }

    // Progress is based on today's reminders only
    private var wateringProgress: Double {
        guard !todayPlants.isEmpty else {
            return 0
        }

        return Double(completedCount)
            / Double(todayPlants.count)
    }

    // Show All Done when there are plants,
    // but no reminders left to complete today
    private var allDone: Bool {
        !plants.isEmpty &&
        completedCount == todayPlants.count
    }

    var body: some View {

        ZStack {

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

                // MARK: - Today's Progress
                if !allDone {

                    VStack(spacing: 15) {

                        
                        Text(
                            completedCount == 0
                                ? "Your plants are waiting for a sip 💦"
                                : "\(completedCount) of your plants feel loved today ✨"
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

                // MARK: - Completed Screen or Today's List
                if allDone {

                    AllRemindersCompletedView()

                } else {

                    List(todayPlants) { plant in

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

