// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "markdown_core",
    products: [
        .library(name: "markdown_core", targets: ["markdown_core"]),
    ],
    targets: [
        .target(
            name: "markdown_core",
            dependencies: [
                "markdown_bridge",
                "markdown_core_ast",
            ],
            path: "markdown_core",
        ),
        .target(
            name: "markdown_core_ast",
            path: "markdown_core_ast",
        ),
        .testTarget(
            name: "markdown_core_test",
            dependencies: [
                "markdown_core",
                "markdown_core_ast",
            ],
            path: "markdown_core_test"
        ),
        .binaryTarget(
            name: "markdown_bridge",
            path: "markdown_bridge/markdown_bridge.xcframework"
        ),
    ]
)
