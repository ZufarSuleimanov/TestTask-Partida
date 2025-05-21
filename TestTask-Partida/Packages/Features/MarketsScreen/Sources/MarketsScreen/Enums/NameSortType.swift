import Foundation

enum NameSortType: CaseIterable {
    case nameDescending
    case nameAscending
    case volumeDescending
    
    mutating func toggle() {
        switch self {
        case .nameDescending: self = .nameAscending
        case .nameAscending: self = .volumeDescending
        case .volumeDescending: self = .nameDescending
        }
    }
}
