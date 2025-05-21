import SwiftUI
import Factory
import MarketsScreen


private struct MarketsScreen: View {
    var body: some View {
        MarketsViewFactoryView(
            marketService: Container.shared.marketService()
        )
    }
}

extension Container {
    func makeMarketsScreen() -> some View {
        MarketsScreen()
    }
}
