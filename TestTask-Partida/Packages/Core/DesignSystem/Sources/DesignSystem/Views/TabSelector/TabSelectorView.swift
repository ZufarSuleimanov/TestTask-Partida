import SwiftUI
import Observation

public protocol TabSelectable: Identifiable, Observable {
    var title: String { get }
    var isSelected: Bool { get set }
}

public struct TabSelectorView<T: TabSelectable>: View {
    @Binding var items: [T]

    public init(items: Binding<[T]>) {
        self._items = items
    }

    public var body: some View {
        HStack(spacing: Spacing.padding_3) {
            ForEach(items) { item in
                Button {
                    for index in items.indices {
                        items[index].isSelected = (items[index].id == item.id)
                    }
                } label: {
                    Text(item.title)
                        .font(Resources.Font.SFPro18)
                        .fontWeight(item.isSelected ? .bold : .regular)
                        .foregroundColor(item.isSelected ? .primary : .gray)
                }
                .buttonStyle(.plain)
            }
            Spacer(minLength: .zero)
        }
        .padding(.horizontal, Spacing.padding_2)
        .padding(.vertical, Spacing.padding_1)
    }
}

@Observable
fileprivate final class TabSelectorModel: TabSelectable {
    let id = UUID()
    let title: String
    var isSelected: Bool

    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}

fileprivate struct TabSelectorViewPreview: View {
    @State private var marketTabs = [
        TabSelectorModel(title: "Favorites"),
        TabSelectorModel(title: "Spot", isSelected: true),
        TabSelectorModel(title: "Ranking")
    ]

    var body: some View {
        TabSelectorView(items: $marketTabs)
    }
}

#Preview {
    TabSelectorViewPreview()
}
