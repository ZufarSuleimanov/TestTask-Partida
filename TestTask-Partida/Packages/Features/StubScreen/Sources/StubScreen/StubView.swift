import SwiftUI
import DesignSystem

public struct StubView: View {
    @Bindable public var viewModel: StubViewModel
    
    public init(viewModel: Bindable<StubViewModel>) {
        self._viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            Resources.Colors.Interface.backgroundPrimary.rawValue.color
                .ignoresSafeArea()
            Text(String(localized: "stub.hw"))
        }
    }
}


#Preview {
    StubView(
        viewModel: Bindable(
            wrappedValue: StubViewModel()
        )
    )
}
