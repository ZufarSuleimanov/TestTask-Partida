import SwiftUI

struct TabBarItem: Identifiable, Hashable {
    var id: UUID = UUID()
    let title: String
    let systemImage: String
    let viewBuilder: () -> AnyView

    static func == (lhs: TabBarItem, rhs: TabBarItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
