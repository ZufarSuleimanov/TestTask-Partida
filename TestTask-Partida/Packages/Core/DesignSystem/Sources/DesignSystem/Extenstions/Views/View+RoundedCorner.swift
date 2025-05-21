import SwiftUI

public extension View {
    func cornerRadius(
        _ radius: CGFloat,
        corners: UIRectCorner
    ) -> some View {
        clipShape(
            Rounded(
                radius: radius,
                corners: corners
            )
        )
    }
}
