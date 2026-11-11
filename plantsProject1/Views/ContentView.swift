import SwiftUI
import Playgrounds
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var plants: [Plant]
    
    private let viewModel = PlantViewModel()
    
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

                List(plants) { plant in
                    PlantRow(plant: plant)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color("Background"))
                        .listRowSeparator(.hidden)
                }
                .scrollContentBackground(.hidden)
            }
        }
        .preferredColorScheme(.dark)
    }
}


#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
