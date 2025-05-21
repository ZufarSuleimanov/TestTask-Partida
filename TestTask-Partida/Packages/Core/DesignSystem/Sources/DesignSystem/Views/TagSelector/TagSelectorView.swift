import SwiftUI
import Observation

public protocol TagSelectable: Identifiable, Observable {
    var title: String { get }
    var isSelected: Bool { get set }
}

public struct TagSelectorView<T: TagSelectable>: View {
    @Binding var items: [T]

    public init(items: Binding<[T]>) {
        self._items = items
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.padding_1) {
                ForEach(items) { item in
                    Button {
                        for index in items.indices {
                            items[index].isSelected = (items[index].id == item.id)
                        }
                    } label: {
                        Text(item.title)
                            .font(Resources.Font.SFPro14)
                            .fontWeight(.regular)
                            .foregroundColor(
                                item.isSelected
                                ? Resources.Colors.Interface.textPrimary.rawValue.color
                                : Resources.Colors.Interface.textSecondary.rawValue.color
                            )
                            .padding(.horizontal, Spacing.padding_2)
                            .padding(.vertical, Spacing.padding_1)
                            .background(
                                Capsule()
                                    .fill(
                                        item.isSelected
                                        ? Resources.Colors.Interface.line.rawValue.color
                                        : Resources.Colors.Interface.backgroundSecondary.rawValue.color
                                    )
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, Spacing.padding_2)
        }
    }
}

@Observable
fileprivate final class TagItemModel: TagSelectable {
    let id = UUID()
    let title: String
    var isSelected: Bool

    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}

fileprivate struct TagSelectorPreview: View {
    @State private var tags = [
        TagItemModel(title: "BNB"),
        TagItemModel(title: "DOGE", isSelected: true),
        TagItemModel(title: "ETH"),
        TagItemModel(title: "MATIC"),
        TagItemModel(title: "SOL"),
        TagItemModel(title: "TRX"),
        TagItemModel(title: "XLM")
    ]

    var body: some View {
        TagSelectorView(items: $tags)
    }
}

#Preview {
    TagSelectorPreview()
}
