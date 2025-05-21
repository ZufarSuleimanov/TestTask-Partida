import SwiftUI
import UIKit

public extension Resources {
    enum Colors {
        public enum Interface: String {
            case backgroundPrimary = "BackgroundPrimary"
            case backgroundSecondary = "BackgroundSecondary"
            case iconPrimary = "IconPrimary"
            case iconSecondary = "IconSecondary"
            case line = "Line"
            case textPrimary = "TextPrimary"
            case textSecondary = "TextSecondary"
        }
        
        public enum Trades: String {
            case tradeGreen = "TradeGreen"
            case tradeRed = "TradeRed"
            case tradeGrey = "TradeGrey"
        }
    }
}

public extension String {
    var uiColor: UIColor {
        UIColor(
            named: self,
            in: .module,
            compatibleWith: nil
        ) ?? .clear
    }
    
    var color: Color {
        Color(uiColor: uiColor)
    }
}
