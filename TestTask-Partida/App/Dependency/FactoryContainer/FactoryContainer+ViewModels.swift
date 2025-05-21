import SwiftUI
import Factory

extension Container {
    var tabBarViewModel: Factory<TabBarViewModel> {
        self {
            TabBarViewModel(tabs: [
                TabBarItem(
                    title: "Home",
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
                ),
                TabBarItem(
                    title: "Trade",
                    systemImage: "bitcoinsign.arrow.trianglehead.counterclockwise.rotate.90",
                    viewBuilder: { [weak self] in
                        AnyView(self?.makeStubScreen())
                    }
                ),
                TabBarItem(
                    title: "Assets",
                    systemImage: "rectangle.3.group.fill",
                    viewBuilder: { [weak self] in
                        AnyView(self?.makeStubScreen())
                    }
                )
            ])
        }
    }
}
