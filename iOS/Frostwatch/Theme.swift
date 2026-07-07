import SwiftUI

/// frost-morning blue on deep winter navy
enum Theme {
    static let accent = Color(red: 0.2275, green: 0.4314, blue: 0.6471)
    static let accentSecondary = Color(red: 0.1098, green: 0.1686, blue: 0.2392)
    static let background = Color(red: 0.0549, green: 0.0863, blue: 0.1216)
    static let cardBackground = background.opacity(0.6)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 16
}
