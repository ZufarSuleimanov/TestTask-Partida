import Foundation
import Combine
import Observation
import NetworkMonitor

@Observable
public final class NoInternetConnectionViewModel {
    public struct Args {
        let networkMonitor: NetworkMonitoring
        let onEvent: @Sendable (Event) -> Void
    }
    
    private var isConnected: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private let onEvent: (Event) -> Void
    
    private let networkMonitor: NetworkMonitoring
    
    public init(args: Args) {
        self.networkMonitor = args.networkMonitor
        self.onEvent = args.onEvent
        self.setupObserverNetworkMonitor()
    }
    
    private func setupObserverNetworkMonitor() {
        networkMonitor.isConnectedPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] isConnected in
                guard let self = self else { return }
                self.isConnected = isConnected ?? false
                if self.isConnected { self.onEvent(.back) }
            }
            .store(in: &cancellables)
    }
}
