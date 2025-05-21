import SwiftUI

public extension Resources {
    enum Images {
        public static let noInternet = Image(systemName: "wifi.slash")
        enum Search {
            public static let magnifyingGlass = Image(systemName: "magnifyingglass")
            public static let xmark = Image(systemName: "xmark.circle.fill")
        }
        enum Sort {
            public static let chevronUp = Image(systemName: "chevron.up")
            public static let chevronDown = Image(systemName: "chevron.down")
        }
    }
}
