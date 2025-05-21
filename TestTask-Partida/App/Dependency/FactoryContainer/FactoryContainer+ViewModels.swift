import SwiftUI
import Factory

extension Container {
    var tabBarViewModel: Factory<TabBarViewModel> {
        self {
            TabBarViewModel(tabs: [
                TabBarItem(
                    title: "Stub",
                    systemImage: "house.fill",
                    viewBuilder: { [weak self] in
                        AnyView(self?.makeStubScreen())
                    }
                ),
                TabBarItem(
                    title: "Market",
                    systemImage: "chart.bar.xaxis",
                    viewBuilder: { [weak self] in
                        AnyView(self?.makeMarketsScreen())
                    }
                )
            ])
        }
    }
}
