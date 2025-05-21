// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MarketsScreen",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "MarketsScreen",
            targets: ["MarketsScreen"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory", from: "2.5.1"),
        .package(path: "DesignSystem"),
        .package(path: "MarketService"),
    ],
    targets: [
        .target(
            name: "MarketsScreen",
            dependencies: [
                .product(name: "Factory", package: "Factory"),
                "DesignSystem",
                "MarketService",
            ]),
        .testTarget(
            name: "MarketsScreenTests",
            dependencies: ["MarketsScreen"]
        ),
    ]
)
