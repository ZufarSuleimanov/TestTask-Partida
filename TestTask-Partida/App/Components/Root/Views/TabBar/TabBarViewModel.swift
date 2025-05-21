import Observation

@Observable
final class TabBarViewModel {
    var selectedTab: TabBarItem?
    let tabs: [TabBarItem]

    init(tabs: [TabBarItem]) {
        self.tabs = tabs
        self.selectedTab = tabs.first
    }
}
