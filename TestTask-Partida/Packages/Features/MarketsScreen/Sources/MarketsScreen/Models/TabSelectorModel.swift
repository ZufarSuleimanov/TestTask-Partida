import Foundation
import Observation
import DesignSystem

@Observable
final class TabSelectorModel: TabSelectable {
    let id = UUID()
    let title: String
    var isSelected: Bool

    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}
