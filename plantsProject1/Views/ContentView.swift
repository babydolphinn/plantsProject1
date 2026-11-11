import SwiftUI
import Playgrounds
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var plants: [Plant]
    
    private let viewModel = PlantViewModel()
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, Planto! 🌱")
                .font(.largeTitle)

            /* 'context: modelContext' Previously, ContentView called its own function to save a plant.
             Now, it asks the ViewModel to do that work. */
            

            List(plants) { plant in
                       Text(plant.name)
                   }
        }
        .padding()
    }
    
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
