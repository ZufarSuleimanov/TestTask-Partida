import SwiftUI

public protocol SortButtonSelectable: Identifiable, Observable {
    var title: String { get }
    var direction: SortDirection { get set }
}

public enum SortDirection {
    case neutral
    case ascending
    case descending
}

public struct SortButtonView<T: SortButtonSelectable>: View {
    @Binding var item: T
    let onTap: () -> Void

    public init(item: Binding<T>, onTap: @escaping () -> Void) {
        self._item = item
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: onTap) {
            HStack(spacing: Spacing.padding_0_5) {
                Text(item.title)
                    .font(Resources.Font.SFPro12)
                    .foregroundColor(Resources.Colors.Interface.textSecondary.rawValue.color)

                VStack(spacing: .zero) {
                    Resources.Images.Sort.chevronUp
                        .font(.system(size: 11, weight: .semibold))
                        .opacity(item.direction == .ascending ? 1 : 0.3)

                    Resources.Images.Sort.chevronDown
                        .font(.system(size: 11, weight: .semibold))
                        .opacity(item.direction == .descending ? 1 : 0.3)
                }
                .foregroundColor(Resources.Colors.Interface.iconPrimary.rawValue.color)
            }
        }
        .buttonStyle(.plain)
    }
}

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

struct SortButtonPreview: View {
    @State private var sort = SortItemModel(title: "Name")

    var body: some View {
        SortButtonView(item: $sort) {
            switch sort.direction {
            case .neutral: sort.direction = .ascending
            case .ascending: sort.direction = .descending
            case .descending: sort.direction = .neutral
            }
        }
    }
}

#Preview {
    SortButtonPreview()
}
