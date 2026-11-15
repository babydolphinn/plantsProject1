
import SwiftUI
import SwiftData

struct ContentView: View {

    @Query private var plants: [Plant]

    @State private var showingSetReminder = false
    @State private var selectedPlant: Plant? = nil
    
    @Environment(\.modelContext) private var modelContext
    
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
                VStack(
                    alignment: .leading,
                    spacing: 0
                ) {

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

                // MARK: - Progress
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

                // MARK: - Completed or List
                if allDone {

                    AllRemindersCompletedView()

                } else {

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

                                // Open the existing plant
                                // in the same Set Reminder sheet
                                selectedPlant = plant
                                showingSetReminder = true
                            }
                        )
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
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

            // MARK: - Add Button
            VStack {

                Spacer()

                HStack {

                    Spacer()

                    GlassCircleButton(
                        symbol: "plus",
                        isProminent: true,
                        action: {

                            // Open a blank form
                            selectedPlant = nil
                            showingSetReminder = true
                        }
                    )
                }
                .padding(.trailing, 30)
                .padding(.bottom, 41)
            }
        }
        .preferredColorScheme(.dark)

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

