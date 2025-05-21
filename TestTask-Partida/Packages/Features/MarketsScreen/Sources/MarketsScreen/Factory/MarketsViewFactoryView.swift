import SwiftUI
import Factory
import MarketService

@MainActor
public struct MarketsViewFactoryView: View {
    private let viewModel: Bindable<MarketsViewModel>

    public init(
        marketService: MarketServiceProtocol
    ) {
        self.viewModel = Bindable(
            wrappedValue: Container
                .shared
                .marketsViewModel(
                    .init(marketService: marketService)
                )
        )
    }

    public var body: some View {
        MarketsView(viewModel: viewModel)
    }
}
