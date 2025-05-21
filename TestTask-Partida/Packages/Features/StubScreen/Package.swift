// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StubScreen",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "StubScreen",
            targets: ["StubScreen"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory", from: "2.5.1"),
        .package(path: "DesignSystem"),
    ],
    targets: [
        .target(
            name: "StubScreen",
            dependencies: [
                .product(name: "Factory", package: "Factory"),
                "DesignSystem",
            ]),
        .testTarget(
            name: "StubScreenTests",
            dependencies: ["StubScreen"]
        ),
    ]
)
