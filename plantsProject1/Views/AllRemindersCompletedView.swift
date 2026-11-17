
import SwiftUI

struct AllRemindersCompletedView: View {

    var body: some View {
        VStack(spacing: AppSpacing.screenPadding) {

            
            ZStack {
                // Dark oval behind the plant, matching Sketch
                Ellipse()
                    .fill(AppColors.allDoneBlob.opacity(0.58))
                    .frame(width: 219, height: 227)

                // Plant illustration exported from Sketch
                Image("AllDonePlant")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 219, height: 227)
            }


            Text("All Done! 🎉")
                .font(AppTypography.headline)
                .foregroundStyle(AppColors.primaryText)
                .padding(.top, AppSpacing.screenPadding)

            Text("All Reminders Completed")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.emptyStateText)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .offset(y: -35)
        .background(AppColors.background)
    }
}

