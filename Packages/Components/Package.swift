// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Components",
    platforms: [.iOS(.v26)],
    products: [
        .library(
            name: "Components",
            targets: ["Components"]
        ),
    ],
    dependencies: [
        .package(path: "../Theme"),
        .package(path: "../Navigation"),
        .package(path: "../Models")
    ],
    targets: [
        .target(
            name: "Components",
            dependencies: [
                "Theme",
                "Navigation",
                "Models"
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "ComponentsTests",
            dependencies: ["Components"]
        ),
    ]
)
