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
