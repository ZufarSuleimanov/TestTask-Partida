import SwiftUI
import Factory
import StubScreen

struct AppCoordinatorView: View {
    @Bindable var coordinator: AppCoordinatorViewModel

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(.tabbar)
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.build(screen)
                }
        }
        .environment(coordinator)
    }
}
