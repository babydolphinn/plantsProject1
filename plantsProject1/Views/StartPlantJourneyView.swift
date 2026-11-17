
import SwiftUI

struct StartPlantJourneyView: View {

    let onSetReminder: () -> Void

    var body: some View {

        VStack(spacing: 0) {

            Image("JourneyPlant")
                .resizable()
                .scaledToFit()
                .frame(width: 164, height: 200)

            Text("Start your plant journey!")
                .font(AppTypography.headline)
                .foregroundStyle(AppColors.primaryText)
                .multilineTextAlignment(.center)
                .padding(.top, 36)

            Text(
                "Now all your plants will be in one place and we will help you take care of them :)🪴"
            )
            .font(AppTypography.body)
            .foregroundStyle(AppColors.bodyText)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 315)
            .padding(.top, 24)

            Button(action: onSetReminder) {

                Text("Set Plant Reminder")
                    .font(AppTypography.formLabel)
                    .foregroundStyle(AppColors.primaryText)
                    .frame(width: 280, height: 42)
            }
            .buttonStyle(.glassProminent)
            .tint(AppColors.brandGreen)
            .padding(.top, 102)

            Spacer(minLength: 0)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .padding(.top, 50)
        .background(AppColors.background)
    }
}

