import SwiftUI

public struct ChangeIndicatorView: View {
    let change: Double

    public enum Constants {
        static let backgroundSize = CGSize(width: 70.0, height: 37.0)
        static let radius = CGFloat(8)
    }
    
    public init(change: Double) {
        self.change = change
    }

    public var body: some View {
        ZStack {
            backgroundColor
                .frame(
                    width: Constants.backgroundSize.width,
                    height: Constants.backgroundSize.height
                )
                .cornerRadius(
                    Constants.radius,
                    corners: .allCorners
                )
            
            Text(formattedChange)
                .font(Resources.Font.SFPro12)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .frame(width: Constants.backgroundSize.width)
    }

    private var formattedChange: String {
        let sign: String
        switch change {
        case let x where x > 0: sign = "+"
        case 0: sign = ""
        default: sign = "-"
        }

        return "\(sign)\(abs(change).formatted(.number.precision(.fractionLength(2))))%"
    }

    private var backgroundColor: Color {
        switch change {
        case let x where x > 0: return Color.green
        case 0: return Color.gray
        default: return Color.red
        }
    }
}

#Preview {
    VStack {
        ChangeIndicatorView(change: 2.89)
        ChangeIndicatorView(change: 0.0)
        ChangeIndicatorView(change: -0.6)
    }
}
