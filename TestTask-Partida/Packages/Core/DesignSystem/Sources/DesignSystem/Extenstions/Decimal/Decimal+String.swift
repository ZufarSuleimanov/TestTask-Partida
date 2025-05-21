import Foundation

public extension Decimal {
    var groupedString: String {
        let nsDecimal = self as NSDecimalNumber
        let raw = nsDecimal.stringValue

        let parts = raw.split(separator: ".")
        let integerPart = parts.first ?? "0"
        var fractionPart = parts.count > 1 ? parts[1] : Substring("")

        while fractionPart.last == "0" {
            fractionPart.removeLast()
        }

        guard !fractionPart.isEmpty else {
            return String(integerPart)
        }

        let groupedFraction = stride(from: 0, to: fractionPart.count, by: 3).map { i -> String in
            let start = fractionPart.index(fractionPart.startIndex, offsetBy: i)
            let end = fractionPart.index(start, offsetBy: 3, limitedBy: fractionPart.endIndex) ?? fractionPart.endIndex
            return String(fractionPart[start..<end])
        }.joined(separator: " ")

        return "\(integerPart).\(groupedFraction)"
    }
}
