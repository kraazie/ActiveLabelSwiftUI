// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "ActiveLabelSwiftUI",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ActiveLabelSwiftUI",
            targets: ["ActiveLabelSwiftUI"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ActiveLabelSwiftUI",
            dependencies: []
        ),
        .testTarget(
            name: "ActiveLabelSwiftUITests",
            dependencies: ["ActiveLabelSwiftUI"]
        ),
    ]
)
