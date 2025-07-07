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
            url: "https://github.com/Lakr233/markdown_core/releases/download/0/markdown_bridge.xcframework.zip",
            checksum: "74bfc82791af7d76113c4a3a4d7de8a7c74300525bb4917132521352b0ad026f"
        ),
        // .binaryTarget(
        //     name: "markdown_bridge",
        //     path: "markdown_bridge/markdown_bridge.xcframework"
        // ),
    ]
)
