// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignSystem",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "DesignSystem",
            targets: [
                "DesignSystem"
            ]),
    ],
    targets: [
        .target(name: "DesignSystem"),
    ]
)
