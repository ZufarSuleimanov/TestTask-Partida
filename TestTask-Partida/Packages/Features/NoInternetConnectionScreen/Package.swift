// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NoInternetConnectionScreen",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "NoInternetConnectionScreen",
            targets: ["NoInternetConnectionScreen"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory", from: "2.5.1"),
        .package(path: "DesignSystem"),
        .package(path: "NetworkMonitor"),
    ],
    targets: [
        .target(
            name: "NoInternetConnectionScreen",
            dependencies: [
                "DesignSystem",
                "NetworkMonitor",
                .product(name: "Factory", package: "Factory")
            ]),
        .testTarget(
            name: "NoInternetConnectionScreenTests",
            dependencies: ["NoInternetConnectionScreen"]
        ),
    ]
)
