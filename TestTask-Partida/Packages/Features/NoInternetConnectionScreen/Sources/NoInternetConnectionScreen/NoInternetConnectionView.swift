import SwiftUI
import Combine
import NetworkMonitor
import DesignSystem

struct NoInternetConnectionView: View {
    @Bindable public var viewModel: NoInternetConnectionViewModel
    
    private enum Constants {
        static let imageSize = CGSize(width: 100.0, height: 100.0)
    }

    init(viewModel: Bindable<NoInternetConnectionViewModel>) {
        self._viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Resources.Colors.Interface.backgroundPrimary.rawValue.color
                .ignoresSafeArea()
            VStack {
                Resources.Images.noInternet
                    .resizable()
                    .frame(
                        width: Constants.imageSize.width,
                        height: Constants.imageSize.height
                    )
                    .tint(Resources.Colors.Interface.iconPrimary.rawValue.color)
                
                Text(String(localized: "noInternetConnection.title"))
                    .font(Resources.Font.SFPro16)
                    .foregroundColor(.primary)
                
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    struct MockNetworkMonitor: NetworkMonitoring {
        var isConnectedPublisher: AnyPublisher<Bool?, Never> {
            Just(false).eraseToAnyPublisher()
        }
    }

    let viewModel = Bindable(
        wrappedValue: NoInternetConnectionViewModel(
            args: .init(
                networkMonitor: MockNetworkMonitor(),
                onEvent: { _ in }
            )
        )
    )

    return NoInternetConnectionView(viewModel: viewModel)
}

