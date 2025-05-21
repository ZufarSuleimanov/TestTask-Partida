import SwiftUI
import Factory

@MainActor
public struct StubViewFactoryView: View {
    private let viewModel = Bindable(wrappedValue: Container.shared.stubViewModel())

    public init() {}

    public var body: some View {
        StubView(viewModel: viewModel)
    }
}
