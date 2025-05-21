import SwiftUI
import NoInternetConnectionScreen

extension AppCoordinatorViewModel {
    
    func makeNoInternetConnectionView() -> some View {
        container.makeNoInternetConnectionScreen { [weak self] event in
            switch event {
            case .back:
                self?.pop()
            }
        }
    }
}
