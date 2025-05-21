import SwiftUI
import Factory
import NoInternetConnectionScreen

private struct NoInternetInnerScreen: View {
    let onEvent: @Sendable (Event) -> Void

    var body: some View {
        NoInternetConnectionViewFactoryView(
            networkMonitor: Container.shared.networkMonitor(),
            onEvent: onEvent
        )
    }
}

extension Container {
    func makeNoInternetConnectionScreen(
        onEvent: @Sendable @escaping (Event) -> Void
    ) -> some View {
        NoInternetInnerScreen(onEvent: onEvent)
    }
}
