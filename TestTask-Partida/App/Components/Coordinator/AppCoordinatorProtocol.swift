import SwiftUI

protocol AppCoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get set }

    func push(_ screen: Screen)
    func pop()
    func popToRoot()
}
