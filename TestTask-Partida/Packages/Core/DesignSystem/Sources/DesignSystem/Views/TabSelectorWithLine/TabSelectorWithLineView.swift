import SwiftUI
import Observation

public protocol TabWithLineSelectable: Identifiable, Observable {
    var title: String { get }
    var isSelected: Bool { get set }
}

fileprivate enum Constants {
    static let bodyHeight = CGFloat(44)
    static let lineHeight = CGFloat(1)
    static let opacity = Double(0.2)
}

public struct TabSelectorWithLineView<T: TabWithLineSelectable>: View {
    @Binding var items: [T]
    @State private var itemWidths: [UUID: CGFloat] = [:]
    
    public init(items: Binding<[T]>) {
        self._items = items
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Color.clear.frame(height: Constants.bodyHeight)
                Rectangle()
                    .fill(Resources.Colors.Interface.backgroundSecondary.rawValue.color)
                    .frame(height: Constants.lineHeight)
                    .padding(.horizontal, Spacing.padding_2)
            }
            HStack(spacing: Spacing.padding_3) {
                ForEach(items) { item in
                    Button {
                        for index in items.indices {
                            items[index].isSelected = (items[index].id == item.id)
                        }
                    } label: {
                        VStack(spacing: Spacing.padding_1) {
                            Text(item.title)
                                .font(Resources.Font.SFPro16)
                                .fontWeight(item.isSelected ? .bold : .regular)
                                .foregroundColor(
                                    item.isSelected
                                    ? Resources.Colors.Interface.textPrimary.rawValue.color
                                    : Resources.Colors.Interface.textSecondary.rawValue.color
                                )
                                .background(WidthReader(id: item.id as! UUID))
                            
                            Rectangle()
                                .fill(
                                    item.isSelected
                                    ? Resources.Colors.Trades.tradeGreen.rawValue.color
                                    : Color.clear
                                )
                                .frame(width: itemWidths[item.id as! UUID] ?? .zero, height: Constants.lineHeight)
                        }
                    }
                    .buttonStyle(.plain)
                }
                
                Spacer(minLength: .zero)
            }
            .padding(.horizontal, Spacing.padding_2)
            .onPreferenceChange(WidthPreferenceKey.self) { widths in
                itemWidths = widths
            }
        }
        .padding(.vertical, Spacing.padding_1_5)
        .frame(height: Constants.bodyHeight)
    }
}

private struct WidthReader: View {
    let id: UUID

    var body: some View {
        GeometryReader { geo in
            Color.clear.preference(key: WidthPreferenceKey.self, value: [id: geo.size.width])
        }
    }
}

private struct WidthPreferenceKey: PreferenceKey {
    static let defaultValue: [UUID: CGFloat] = [:]

    static func reduce(value: inout [UUID: CGFloat], nextValue: () -> [UUID: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

@Observable
fileprivate final class TabSelectorWithLineModel: TabWithLineSelectable {
    let id = UUID()
    let title: String
    var isSelected: Bool

    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}

fileprivate struct TabSelectorWithLinePreview: View {
    @State private var tabs = [
        TabSelectorWithLineModel(title: "USD($)"),
        TabSelectorWithLineModel(title: "BTC", isSelected: true),
        TabSelectorWithLineModel(title: "DeFi"),
        TabSelectorWithLineModel(title: "Other")
    ]
    
    var body: some View {
        TabSelectorWithLineView(items: $tabs)
    }
}

#Preview {
    TabSelectorWithLinePreview()
}
