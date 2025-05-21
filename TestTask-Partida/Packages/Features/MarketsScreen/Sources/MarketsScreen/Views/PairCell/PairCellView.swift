import SwiftUI
import DesignSystem

struct PairCellView: View {
    @Bindable var model: PairCellViewModel
    
    init(model: Bindable<PairCellViewModel>) {
        self._model = model
    }
    
    var body: some View {
        HStack(spacing: Spacing.padding_0_5) {
            MarketVolumeView(
                crypto: model.crypto,
                fiat: model.fiat,
                volume: model.volume
            )
            Spacer()
            PriceVolumeView(
                amount: model.price,
                price: model.priceUsd
            )
            ChangeIndicatorView(change: model.change)
        }
    }
}

#Preview {
    PairCellView(
        model: Bindable(
            wrappedValue: .init(
                key: "BTC/USDT",
                pairName: "BTC/USDT",
                volume: "100.47",
                price: 0.000000341788,
                priceUsd: 0.000000342,
                change: 1.4
            )
        )
    )
}
