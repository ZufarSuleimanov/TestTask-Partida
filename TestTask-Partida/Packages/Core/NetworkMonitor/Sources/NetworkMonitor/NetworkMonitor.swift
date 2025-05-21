import Foundation
import Network
import Observation
import Combine

public protocol NetworkMonitoring: Sendable {
    var isConnectedPublisher: AnyPublisher<Bool?, Never> { get }
}


@Observable
public final class NetworkMonitor: NetworkMonitoring, @unchecked Sendable {
    private let isConnectedSubject = CurrentValueSubject<Bool?, Never>(nil)
    public var isConnectedPublisher: AnyPublisher<Bool?, Never> {
        isConnectedSubject.eraseToAnyPublisher()
    }
    private var connectionType: NWInterface.InterfaceType?

    private let queue = DispatchQueue(label: "Monitor")
    private let monitor = NWPathMonitor()

    public init() {
        startMonitoring()
    }

    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }

            Task { @MainActor in
                self.isConnectedSubject.send(path.status == .satisfied)

                let types: [NWInterface.InterfaceType] = [.wifi, .cellular, .wiredEthernet, .loopback]
                if let type = types.first(where: { path.usesInterfaceType($0) }) {
                    self.connectionType = type
                } else {
                    self.connectionType = nil
                }
            }
        }

        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}
