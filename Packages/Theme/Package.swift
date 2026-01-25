// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Theme",
    platforms: [.iOS(.v26)],
    products: [
        .library(
            name: "Theme",
            targets: ["Theme"]
        ),
    ],
    targets: [
        .target(
            name: "Theme",
            resources: [
                .process("Resources")
            ]
        ),

    ]
)
