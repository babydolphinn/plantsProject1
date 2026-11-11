
import SwiftUI

struct AnimatedProgressBar: View {

    // A value between 0 (empty) and 1 (full)
    let progress: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {

                // Background track
                Capsule()
                    .fill(Color("ProgressTrack"))

                // Filled portion
                Capsule()
                    .fill(Color("BrandGreen"))
                    .frame(
                        width: geometry.size.width *
                            min(max(progress, 0), 1)
                    )
            }
        }
        .frame(height: 10)
        .animation(.easeInOut(duration: 0.3), value: progress)
        .accessibilityLabel("Watering progress")
        .accessibilityValue("\(Int(min(max(progress, 0), 1) * 100)) percent")
    }
}

