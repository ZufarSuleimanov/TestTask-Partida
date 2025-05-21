// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WebSocketClient",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "WebSocketClient",
            targets: ["WebSocketClient"]),
    ],
    targets: [
        .target(name: "WebSocketClient"),
    ]
)
