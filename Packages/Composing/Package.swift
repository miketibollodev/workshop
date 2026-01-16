// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Composing",
    platforms: [.iOS(.v26)],
    products: [
        .library(
            name: "Composing",
            targets: ["Composing"]
        ),
    ],
    dependencies: [
        .package(path: "../Styling")
    ],
    targets: [
        .target(
            name: "Composing",
            dependencies: [
                "Styling"
            ]
        ),
        .testTarget(
            name: "ComposingTests",
            dependencies: ["Composing"]
        ),
    ]
)
