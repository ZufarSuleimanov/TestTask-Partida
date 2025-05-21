import Foundation
import Observation
import DesignSystem

@Observable
final class TabSelectorWithLineModel: TabWithLineSelectable {
    let id = UUID()
    let title: String
    let type: TabSelectorWithLineType
    var onSelect: (TabSelectorWithLineType) -> Void

    private var _isSelected: Bool = false
    var isSelected: Bool {
        get { _isSelected }
        set {
            _isSelected = newValue
            if newValue {
                onSelect(type)
            }
        }
    }

    init(
        title: String,
        type: TabSelectorWithLineType,
        isSelected: Bool = false,
        onSelect: @escaping (TabSelectorWithLineType) -> Void
    ) {
        self.title = title
        self.type = type
        self._isSelected = isSelected
        self.onSelect = onSelect
    }
}

enum TabSelectorWithLineType: String, CaseIterable {
    case usds = "USD($)"
    case btc = "BTC"
    case defi = "DeFi"
    case other = "Other"
}
