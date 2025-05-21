import SwiftUI

public struct MarketVolumeView: View {
    private let crypto: String
    private let fiat: String
    private let volume: String

    public init(
        crypto: String,
        fiat: String,
        volume: String
    ) {
        self.crypto = crypto
        self.fiat = fiat
        self.volume = volume
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.padding_0_5) {
            HStack(alignment: .firstTextBaseline, spacing: Spacing.padding_0_25) {
                Text(crypto)
                    .font(Resources.Font.SFPro16)
                    .fontWeight(.bold)
                    .foregroundColor(Resources.Colors.Interface.textPrimary.rawValue.color)

                Text("/\(fiat)")
                    .font(Resources.Font.SFPro14)
                    .foregroundColor(Resources.Colors.Interface.textSecondary.rawValue.color)
            }

            var newVolume = volume == "0" ? "Vol \(volume)" : "Vol \(volume)М"
            Text(newVolume)
                .font(Resources.Font.SFPro12)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    MarketVolumeView(
        crypto: "BTC",
        fiat: "USDT",
        volume: "288.35"
    )
}
