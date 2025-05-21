import SwiftUI

public extension View {
    func roundedBorder<S>(
        _ content: S,
        width: CGFloat = 1,
        cornerRadius: CGFloat,
        corners: UIRectCorner
    ) -> some View where S : ShapeStyle {
        let roundedRect = Rounded(
            radius: cornerRadius,
            corners: corners
        )
        return clipShape(roundedRect)
            .overlay(
                roundedRect
                    .stroke(content, lineWidth: width)
            )
    }
}
