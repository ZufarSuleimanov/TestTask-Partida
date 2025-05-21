import SwiftUI
import MarketService
import DesignSystem

public struct MarketsView: View {
    @Bindable public var viewModel: MarketsViewModel
    
    public init(viewModel: Bindable<MarketsViewModel>) {
        self._viewModel = viewModel
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            Resources.Colors.Interface.backgroundPrimary.rawValue.color
                .ignoresSafeArea()
            VStack(spacing: Spacing.padding_0_25) {
                searchView
                tabSelectorView
                tabSelectorWithLineView
                if !viewModel.activeTags.isEmpty {
                    tagSelectorView
                }
                sortsView
                if !viewModel.pairs.isEmpty {
                    pairsView
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
        }
    }
}

extension MarketsView {
    
    @ViewBuilder
    var searchView: some View {
        SearchView(
            placeholder: String(localized: "markets.search"),
            onTextChanged: { _ in }
        )
        .frame(height: 32)
        .padding(.horizontal, Spacing.padding_2)
        .padding(.vertical, Spacing.padding_2)
    }
    
    var tabSelectorView: some View {
        TabSelectorView(items: $viewModel.tabs)
            .frame(height: 42)
    }
    
    var tabSelectorWithLineView: some View {
        TabSelectorWithLineView(items: $viewModel.tabsWithLine)
            .frame(height: 42)
    }
    
    var tagSelectorView: some View {
        TagSelectorView(items: $viewModel.activeTags)
            .frame(height: 42)
            .padding(.top, Spacing.padding_2)
    }
    
    var sortsView: some View {
        HStack(spacing: Spacing.padding_1_5) {
            SortButtonView(
                item: $viewModel.sortNemes,
                onTap: { viewModel.currentSort.toggle() }
            )
            SortButtonView(
                item: $viewModel.sortVols,
                onTap: {  }
            )
            Spacer()
            SortButtonView(
                item: $viewModel.sortLasts,
                onTap: {  }
            )
            SortButtonView(
                item: $viewModel.sortTimes,
                onTap: {  }
            )
        }
        .frame(height: 42)
        .padding(.horizontal, Spacing.padding_2)
        .padding(.top, Spacing.padding_0_5)
    }
    
    var pairsView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: Spacing.padding_1) {
                ForEach(viewModel.sortedPairs(), id: \.id) { model in
                    PairCellView(model: Bindable(wrappedValue: model))
                }
            }
            .padding(.horizontal, Spacing.padding_2)
        }
        .refreshable {
            viewModel.disconnectWebSocket()
            await viewModel.fetchData()
            viewModel.initializeWebSocketFlow()
        }
        .onAppear {
            viewModel.initializeWebSocketFlow()
        }
    }
}

 #Preview {
    let mockViewModel = MarketsViewModel(
        args: .init(
            marketService: DummyMarketService(
                response: makeMarketListResponseFromJSON()
            )
        )
    )
    
    MarketsView(viewModel: Bindable(wrappedValue: mockViewModel))
}
