// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MarketService",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "MarketService",
            targets: ["MarketService"]),
    ],
    dependencies: [
        .package(path: "NetworkClient"),
        .package(path: "WebSocketClient"),
    ],
    targets: [
        .target(
            name: "MarketService",
            dependencies: [
                "NetworkClient",
                "WebSocketClient",
            ]
        ),
        .testTarget(
            name: "MarketServiceTests",
            dependencies: ["MarketService"]
        ),
    ]
)
