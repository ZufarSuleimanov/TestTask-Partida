import SwiftUI

public struct PriceVolumeView: View {
    private let amount: Double
    private let price: Double

    public init(
        amount: Double,
        price: Double
    ) {
        self.amount = amount
        self.price = price
    }

    public var body: some View {
        VStack(alignment: .trailing, spacing: Spacing.padding_0_5) {
            Text((Decimal(string: "\(amount)") ?? .zero).groupedString)
                .font(Resources.Font.SFPro16)
                .fontWeight(.bold)
                .foregroundColor(Resources.Colors.Interface.textPrimary.rawValue.color)

            Text("$\(Decimal(string: "\(price)") ?? .zero)")
                .font(Resources.Font.SFPro12)
                .foregroundColor(Resources.Colors.Interface.textSecondary.rawValue.color)
        }
    }
}

#Preview {
    PriceVolumeView(
        amount: 1.877022653721689,
        price: 1.877022653721689
    )
}
