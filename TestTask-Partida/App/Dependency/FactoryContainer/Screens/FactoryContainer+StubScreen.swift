import SwiftUI
import Factory
import StubScreen

extension Container {
    func makeStubScreen() -> some View {
        struct Inner: View {
            var body: some View {
                StubViewFactoryView()
            }
        }

        return Inner()
    }
}
