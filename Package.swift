// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "PlistViewer",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "PlistViewer",
            targets: ["PlistViewer"]
        ),
    ],
    targets: [
        .target(
            name: "PlistViewer"
        ),
        .testTarget(
            name: "PlistViewerTests",
            dependencies: ["PlistViewer"]
        ),
    ]
)
