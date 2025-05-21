import Foundation
import MarketService
import Observation

@Observable
public final class MarketsViewModel {
    var tabs: [TabSelectorModel] = []
    var tabsWithLine: [TabSelectorWithLineModel] = []
    
    var tagsBtc: [TagItemModel] = []
    var tagsDefi: [TagItemModel] = []
    var tagsUsds: [TagItemModel] = []
    var tagsOther: [TagItemModel] = []
    var activeTags: [TagItemModel] = []
    var pairs: [String: PairCellViewModel] = [:]
    var activeTag: String = ""
    var currentSort: NameSortType = .volumeDescending
    
    var sortNemes: SortItemModel = SortItemModel(title: "Name")
    var sortVols: SortItemModel = SortItemModel(title: "Vol")
    var sortLasts: SortItemModel = SortItemModel(title: "Last")
    var sortTimes: SortItemModel = SortItemModel(title: "24H Change")
    
    public struct Args {
        let marketService: MarketServiceProtocol
    }
    
    private let marketService: MarketServiceProtocol
    
    public init(args: Args) {
        self.marketService = args.marketService
        makeTabs()
        makeTabsWithLine()
    }
    
    func sortedPairs() -> [PairCellViewModel] {
        let filtered = pairs.values.filter { $0.fiat.contains(activeTag) }
        switch currentSort {
        case .nameDescending:
            return filtered.sorted { $0.crypto > $1.crypto }
        case .nameAscending:
            return filtered.sorted { $0.crypto < $1.crypto }
        case .volumeDescending:
            return filtered.sorted { $0.volumeDouble > $1.volumeDouble }
        }
    }
    
    private func makeTabs() {
        tabs = [
            TabSelectorModel(title: "Favorites"),
            TabSelectorModel(title: "Spot", isSelected: true),
            TabSelectorModel(title: "Ranking")
        ]
    }
    
    private func makeTabsWithLine() {
        tabsWithLine = TabSelectorWithLineType
            .allCases
            .map {
                TabSelectorWithLineModel(
                    title: $0.rawValue,
                    type: $0,
                    onSelect: { [weak self] type in
                        guard let self else { return }
                        self.resetAllTags()
                        switch type {
                        case .usds:
                            self.activeTags = self.tagsUsds
                            self.tagsUsds.first?.isSelected = true
                            self.activeTag = self.tagsUsds.first?.title ?? ""
                        case .btc:
                            self.activeTags = self.tagsBtc
                            self.tagsBtc.first?.isSelected = true
                            self.activeTag = self.tagsBtc.first?.title ?? ""
                        case .defi:
                            self.activeTags = self.tagsDefi
                            self.tagsDefi.first?.isSelected = true
                            self.activeTag = self.tagsDefi.first?.title ?? ""
                        case .other:
                            self.activeTags = self.tagsOther
                            self.tagsOther.first?.isSelected = true
                            self.activeTag = self.tagsOther.first?.title ?? ""
                        }
                    }
                )
            }
    }
    
    func resetAllTags() {
        tagsUsds.forEach { $0.isSelected = false }
        tagsBtc.forEach { $0.isSelected = false }
        tagsDefi.forEach { $0.isSelected = false }
        tagsOther.forEach { $0.isSelected = false }
    }
    
    @MainActor
    func fetchData() async {
        Task {
            do {
                let response = try await marketService.fetchMarketList()
                await MainActor.run {
                    self.makeTagModels(tabs: response.response.tabs)
                    self.makePairCellViewModels(currencies: response.response.currencies)
                }
            } catch {
                print("Error:", error)
            }
        }
    }
    
    func makeTagModels(tabs: Tabs) {
        func build(from value: TabsValue?) -> [TagItemModel] {
            value?
                .values
                .map {
                    TagItemModel(
                        title: $0,
                        onSelect: { [weak self] tag in
                            guard let self else { return }
                            activeTag = tag
                        }
                    )
                } ?? []
        }
        
        tagsBtc = build(from: tabs.BTC)
        tagsDefi = build(from: tabs.DeFi)
        tagsUsds = build(from: tabs.USDs)
        tagsOther = build(from: tabs.OTHER)

        tabsWithLine.first?.isSelected = true
        tagsUsds.first?.isSelected = true
    }
    
    func makePairCellViewModels(currencies: [String: CurrencyInfo]) {
        pairs = currencies.reduce(into: [:]) { result, element in
            let (key, value) = element
            let model = PairCellViewModel(
                key: extractSecondComponent(from: value.tabName),
                pairName: value.pairName,
                volume: value.volume ?? "0",
                price: Double(value.price ?? "0") ?? 0,
                priceUsd: Double(value.priceUsd ?? "0") ?? 0,
                change: Double(value.change ?? "0") ?? 0
            )
            result[key] = model
        }
    }
    
    func extractSecondComponent(from string: String) -> String {
        return string.split(separator: "/").dropFirst().first.map(String.init) ?? string
    }

    @MainActor
    func initializeWebSocketFlow() {
        Task {
            do {
                try await marketService.connectToWebSocket()
                try await marketService.subscribeToMarkets(Array(pairs.keys))
                startReceivingUpdates()
            } catch {
                print("WebSocket setup error:", error)
            }
        }
    }
    
    @MainActor
    func connectToWebSocket() {
        Task {
            do {
                try await marketService.connectToWebSocket()
                print("✅ WebSocket connected")
            } catch {
                print("WebSocket connection error:", error)
            }
        }
    }

    @MainActor
    func disconnectWebSocket() {
        marketService.disconnectWebSocket()
    }

    @MainActor
    func subscribeToMarkets() {
        let marketIds = Array(pairs.keys)
        Task {
            do {
                try await marketService.subscribeToMarkets(marketIds)
            } catch {
                print("Subscription error:", error)
            }
        }
    }

    @MainActor
    func startReceivingUpdates() {
        let buffer = UpdatesBuffer()
        let marketService = self.marketService

        Task {
            while true {
                do {
                    let message = try await marketService.receiveMarketUpdate()

                    if case .update(let update) = message {
                        await buffer.set(symbol: update.params.symbol, stats: update.params.stats)
                    }
                } catch {
                    print("Receive error:", error)
                    break
                }
            }
        }

        Task {
            while true {
                try? await Task.sleep(nanoseconds: 3 * 1_000_000_000)

                let snapshot = await buffer.snapshotAndClear()

                for (symbol, stats) in snapshot {
                    guard let model = pairs[symbol] else { continue }

                    let newChange = MarketsViewModel.adjustedChange(
                        last: stats.last,
                        open: stats.open
                    )

                    model.volume = stats.volume
                    model.price = Double(stats.last) ?? model.price
                    model.change = newChange
                    pairs[symbol] = model
                }
           }
        }
    }
    
    static func adjustedChange(
        last: String,
        open: String
    ) -> Double {
        guard
            let last = Double(last),
            let open = Double(open),
            open != 0
        else {
            return 0
        }

        return ((last - open) / open) * 100
    }
}

actor UpdatesBuffer {
    private var storage: [String: MarketUpdate.Stats] = [:]

    func set(symbol: String, stats: MarketUpdate.Stats) {
        storage[symbol] = stats
    }

    func snapshotAndClear() -> [String: MarketUpdate.Stats] {
        let snapshot = storage
        storage.removeAll()
        return snapshot
    }
}
