
import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var plants: [Plant]

    // Remember whether the user has ever added a plant.
    @AppStorage("hasEverAddedPlant")
    private var hasEverAddedPlant = false

    @State private var showingSetReminder = false
    @State private var selectedPlant: Plant? = nil

    private let viewModel = PlantViewModel()

    // MARK: - Today's Reminders

    private var todayPlants: [Plant] {
        plants.filter { plant in
            viewModel.isDueToday(plant)
        }
    }

    private var completedCount: Int {
        todayPlants.filter { plant in
            viewModel.isWateredToday(plant)
        }.count
    }

    private var wateringProgress: Double {
        guard !todayPlants.isEmpty else {
            return 0
        }

        return Double(completedCount)
            / Double(todayPlants.count)
    }

    // All Done should only appear when there were
    // actual reminders to complete today.
    private var allDone: Bool {
        !todayPlants.isEmpty &&
        completedCount == todayPlants.count
    }

    // First-time user with no plants
    private var isFirstLaunchEmptyState: Bool {
        plants.isEmpty && !hasEverAddedPlant
    }

    private func openAddReminder() {
        selectedPlant = nil
        showingSetReminder = true
    }

    var body: some View {

        ZStack {

            Color("Background")
                .ignoresSafeArea()

            VStack(spacing: 0) {

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

                // MARK: - First-time Empty State
                if isFirstLaunchEmptyState {

                    StartPlantJourneyView {
                        openAddReminder()
                    }

                // MARK: - No Reminders
                } else if todayPlants.isEmpty {

                    VStack {

                        Spacer()

                        Text("No reminders set yet..")
                            .font(
                                .system(
                                    size: 18,
                                    weight: .medium
                                )
                            )
                            .foregroundStyle(
                                Color("EmptyStateText")
                            )

                        Spacer()
                    }
                    .frame(maxWidth: .infinity)

                // MARK: - All Completed
                } else if allDone {

                    AllRemindersCompletedView()

                // MARK: - Today's Reminder List
                } else {

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

                    List(todayPlants) { plant in

                        PlantRow(
                            plant: plant,
                            onToggle: {

                                withAnimation {
                                    viewModel.toggleWatered(
                                        plant: plant
                                    )
                                }
                            },
                            onEdit: {

                                selectedPlant = plant
                                showingSetReminder = true
                            }
                        )
                        .swipeActions(
                            edge: .trailing,
                            allowsFullSwipe: false
                        ) {

                            Button(role: .destructive) {

                                withAnimation {
                                    viewModel.deletePlant(
                                        plant,
                                        context: modelContext
                                    )
                                }

                            } label: {

                                Image(systemName: "trash")
                            }
                            .tint(Color("DestructiveRed"))
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
            // Hidden only on the first-launch screen
            if !isFirstLaunchEmptyState {

                VStack {

                    Spacer()

                    HStack {

                        Spacer()

                        GlassCircleButton(
                            symbol: "plus",
                            isProminent: true,
                            action: {
                                openAddReminder()
                            }
                        )
                    }
                    .padding(.trailing, 30)
                    .padding(.bottom, 41)
                }
            }
        }
        .preferredColorScheme(.dark)

        // Existing users should never see onboarding
        // again just because they deleted their plants.
        .onAppear {
            if !plants.isEmpty {
                hasEverAddedPlant = true
            }
        }
        .onChange(of: plants.count) { _, count in
            if count > 0 {
                hasEverAddedPlant = true
            }
        }

        // MARK: - Add / Edit Sheet
        .sheet(
            isPresented: $showingSetReminder,
            onDismiss: {
                selectedPlant = nil
            }
        ) {

            SetReminderView(
                plant: selectedPlant
            )
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

