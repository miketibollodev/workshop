// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Styling",
    platforms: [.iOS(.v26)],
    products: [
        .library(
            name: "Styling",
            targets: ["Styling"]
        ),
    ],
    targets: [
        .target(
            name: "Styling",
            resources: [
                .process("Resources")
            ]
        ),

    ]
)
