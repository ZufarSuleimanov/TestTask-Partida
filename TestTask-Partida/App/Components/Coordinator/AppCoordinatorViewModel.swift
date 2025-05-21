import SwiftUI
import Factory
import Observation
import Combine
import NetworkMonitor

@Observable
final class AppCoordinatorViewModel: AppCoordinatorProtocol {
    var path: NavigationPath = NavigationPath()
    let container: Container
    private var isConnected: Bool = true
    private var cancellables = Set<AnyCancellable>()
    @Injected(\.networkMonitor) @ObservationIgnored private var networkMonitor: NetworkMonitoring

    init(container: Container = .shared) {
        self.container = container
        self.setupObserverNetworkMonitor()
    }
    
    private func setupObserverNetworkMonitor() {
        networkMonitor.isConnectedPublisher
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] isConnected in
                guard let self = self else { return }
                self.isConnected = isConnected ?? false
                if !self.isConnected {
                    self.push(.noInternetConnection)
                }
            }
            .store(in: &cancellables)
    }

    func push(_ screen: Screen) {
        path.append(screen)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    @MainActor @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .tabbar: TabBarView(viewModel: Bindable(wrappedValue: Container.shared.tabBarViewModel()))
        case .noInternetConnection: makeNoInternetConnectionView()
        }
    }
}

extension AppCoordinatorViewModel: @unchecked Sendable {}
