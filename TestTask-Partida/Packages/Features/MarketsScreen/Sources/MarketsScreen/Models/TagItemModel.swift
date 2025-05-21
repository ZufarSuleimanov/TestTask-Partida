import Foundation
import Observation
import DesignSystem

@Observable
final class TagItemModel: TagSelectable {
    let id = UUID()
    let title: String
    var onSelect: ((String) -> Void)
    
    private var _isSelected: Bool = false
    var isSelected: Bool {
        get { _isSelected }
        set {
            _isSelected = newValue
            if newValue {
                onSelect(title)
            }
        }
    }

    init(
        title: String,
        isSelected: Bool = false,
        onSelect: @escaping ((String) -> Void)
    ) {
        self.title = title
        self._isSelected = isSelected
        self.onSelect = onSelect
    }
}
