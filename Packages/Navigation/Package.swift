// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Navigation",
    platforms: [.iOS(.v26)],
    products: [
        .library(
            name: "Navigation",
            targets: ["Navigation"]
        ),
    ],
    dependencies: [
        .package(path: "../Models")
    ],
    targets: [
        .target(
            name: "Navigation",
            dependencies: [
                "Models"
            ]
        ),
        .testTarget(
            name: "NavigationTests",
            dependencies: ["Navigation"]
        ),
    ]
)
