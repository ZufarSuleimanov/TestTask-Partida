import SwiftUI
import DesignSystem

struct TabBarView: View {
    @Bindable var viewModel: TabBarViewModel

    init(viewModel: Bindable<TabBarViewModel>) {
        self._viewModel = viewModel
        setupTabBarAppearance()
    }

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(viewModel.tabs) { item in
                item.viewBuilder()
                    .tabItem {
                        Label(item.title, systemImage: item.systemImage)
                    }
                    .tag(item)
            }
        }
        .accentColor(Resources.Colors.Interface.iconPrimary.rawValue.color)
    }

    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = Resources.Colors.Interface.backgroundPrimary.rawValue.uiColor
        appearance.shadowImage = nil
        appearance.shadowColor = nil

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
