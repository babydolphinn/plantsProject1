
import SwiftUI

struct PickerRow<Option: Hashable & RawRepresentable & CaseIterable>: View
where Option.RawValue == String {

    let title: String
    let symbol: String
    let options: [Option]

    @Binding var selection: Option

    var body: some View {
        HStack(spacing: AppSpacing.screenPadding) {

            Image(systemName: symbol)
                .foregroundStyle(AppColors.secondaryText)

            Text(title)
                .font(AppTypography.formLabel)
                .foregroundStyle(AppColors.primaryText)

            Spacer()

            Picker(title, selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)
            .tint(AppColors.secondaryText)
        }
        .padding(.horizontal, AppSpacing.screenPadding)
        .frame(height: 44)
    }
}

