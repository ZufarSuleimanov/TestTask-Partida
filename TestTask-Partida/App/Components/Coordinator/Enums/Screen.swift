import Foundation

enum Screen: Identifiable, Hashable {
    case tabbar
    case noInternetConnection
    
    var id: Self { self }
}
