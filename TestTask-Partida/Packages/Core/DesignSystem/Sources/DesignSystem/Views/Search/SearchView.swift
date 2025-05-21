import SwiftUI

public struct SearchView: View {
    @State private var text: String = ""
    let placeholder: String
    let onTextChanged: (String) -> Void
    
    private enum Constants {
        static let cornerRadius = CGFloat(16)
    }
    
    public init(
        placeholder: String,
        onTextChanged: @escaping (String) -> Void
    ) {
        self.placeholder = placeholder
        self.onTextChanged = onTextChanged
    }
    
    public var body: some View {
        HStack(spacing: Spacing.padding_1) {
            Resources.Images.Search.magnifyingGlass
                .foregroundColor(Resources.Colors.Interface.iconSecondary.rawValue.color)
            
            TextField(placeholder, text: $text)
                .font(Resources.Font.SFPro14)
                .tint(Resources.Colors.Interface.iconPrimary.rawValue.color)
                .foregroundColor(Resources.Colors.Interface.iconPrimary.rawValue.color)
                .disableAutocorrection(true)
                .onChange(of: text) { _, newValue in
                    onTextChanged(newValue)
                }
            
            if !text.isEmpty {
                Button(
                    action: {
                        text = ""
                        onTextChanged("")
                    }
                ) {
                    Resources.Images.Search.xmark
                        .foregroundColor(Resources.Colors.Interface.iconPrimary.rawValue.color)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, Spacing.padding_1_5)
        .padding(.vertical, Spacing.padding_2)
        .background(Resources.Colors.Interface.backgroundSecondary.rawValue.color)
        .cornerRadius(Constants.cornerRadius)
    }
}

#Preview {
    SearchView(
        placeholder: "Search",
        onTextChanged: { _ in }
    )
    .padding(.horizontal, Spacing.padding_2)
}
