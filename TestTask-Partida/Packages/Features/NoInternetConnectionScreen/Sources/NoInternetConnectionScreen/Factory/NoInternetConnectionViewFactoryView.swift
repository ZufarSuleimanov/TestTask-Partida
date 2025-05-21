import SwiftUI
import Factory
import NetworkMonitor

@MainActor
public struct NoInternetConnectionViewFactoryView: View {
    private let viewModel: Bindable<NoInternetConnectionViewModel>

    private let onEvent: @Sendable (Event) -> Void

    public init(
        networkMonitor: NetworkMonitoring,
        onEvent: @Sendable @escaping (Event) -> Void
    ) {
        self.onEvent = onEvent
        self.viewModel = Bindable(
            wrappedValue: Container
                .shared
                .noInternetConnectionViewModel(
                    .init(
                        networkMonitor: networkMonitor,
                        onEvent: onEvent
                    )
                )
        )
    }

    public var body: some View {
        NoInternetConnectionView(viewModel: viewModel)
    }
}
