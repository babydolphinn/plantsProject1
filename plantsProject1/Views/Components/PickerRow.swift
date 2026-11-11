
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
                .foregroundStyle(Color("SecondaryText"))

            Text(title)
                .font(AppTypography.formLabel)
                .foregroundStyle(.white)

            Spacer()

            Picker(title, selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)
            .tint(Color("SecondaryText"))
        }
        .padding(.horizontal, AppSpacing.screenPadding)
        .frame(height: 44)
    }
}

