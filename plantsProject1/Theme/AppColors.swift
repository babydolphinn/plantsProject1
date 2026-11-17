import SwiftUI

// Planto's fixed dark theme, using the original Sketch/Assets RGB values.
enum AppColors {
    private static func rgb(_ hex: UInt32) -> Color {
        Color(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: 1
        )
    }

    static let background = rgb(0x000000)
    static let sheetBackground = rgb(0x1C1C1E)
    static let cardBackground = rgb(0x2C2C2E)
    static let cardDivider = rgb(0x414144)
    static let headerDivider = rgb(0x181819)
    static let rowDivider = rgb(0x222224)
    static let pillBackground = rgb(0x18181D)
    static let bodyText = rgb(0x9F9F91)
    static let secondaryText = rgb(0x8E8E93)
    static let placeholderText = rgb(0x666666)
    static let emptyStateText = rgb(0x756F6F)
    static let brandGreen = rgb(0x338069)
    static let mintAccent = rgb(0x28E0A8)
    static let sunTag = rgb(0xCCC785)
    static let waterTag = rgb(0xBFD8EA)
    static let checkboxRing = rgb(0x979797)
    static let progressTrack = rgb(0x262626)
    static let destructiveRed = rgb(0xFF3B30)
    static let allDoneBlob = rgb(0x14141A)
    static let primaryText = rgb(0xFFFFFF)
}
