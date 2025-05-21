import Foundation
import Observation
import DesignSystem

@Observable
final class SortItemModel: SortButtonSelectable {
    let id = UUID()
    let title: String
    var direction: SortDirection

    init(title: String, direction: SortDirection = .neutral) {
        self.title = title
        self.direction = direction
    }
}
