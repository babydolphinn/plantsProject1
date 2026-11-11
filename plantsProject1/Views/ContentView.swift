import SwiftUI
import Playgrounds
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var plants: [Plant]
    @State private var showingSetReminder = false
    private let viewModel = PlantViewModel()
    
    private var completedCount: Int {
        plants.filter { plant in
            guard let lastWatered = plant.lastWateredAt else {
                return false
            }

            return Calendar.current.isDateInToday(lastWatered)
        }.count
    } //completedCount counts plants watered today, and wateringProgress converts that count into a value between 0 and 1

    private var wateringProgress: Double {
        guard !plants.isEmpty else { return 0 }

        return Double(completedCount) / Double(plants.count)
    }

    var body: some View {
        ZStack {
            // Our existing background color from Assets
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                VStack(alignment: .leading, spacing: 0) {

                    // Main screen title
                    Text("My Plants 🌱")
                        .font(AppTypography.screenTitle)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, AppSpacing.screenPadding)
                        .padding(.bottom, AppSpacing.screenPadding)

                    // Divider below the header
                    Rectangle()
                        .fill(Color("HeaderDivider"))
                        .frame(height: 1)
                        .padding(.horizontal, AppSpacing.screenPadding)
                }

                VStack(spacing: 15) {

                    // Message shown when no plants are completed
                    Text(
                        completedCount == 0
                            ? "Your plants are waiting for a sip 💦"
                            : "\(completedCount) of \(plants.count) plants watered today 💦"
                    )
                    .font(AppTypography.formLabel)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)

                    AnimatedProgressBar(progress: wateringProgress)

                }
                .padding(.horizontal, AppSpacing.screenPadding)
                .padding(.top, 38)

                List(plants) { plant in
                    PlantRow(plant: plant) {
                        withAnimation {
                            viewModel.toggleWatered(plant: plant)
                        }
                    }
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color("Background"))
                        .listRowSeparator(.hidden)
                }
                .scrollContentBackground(.hidden)
            }
            
            VStack {
                Spacer()

                HStack {
                    Spacer()
// add button
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
        
        .sheet(isPresented: $showingSetReminder) {
            SetReminderView()
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(AppSpacing.sheetRadius)
                .presentationBackground(Color("SheetBackground"))
        }

    }
}


#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
