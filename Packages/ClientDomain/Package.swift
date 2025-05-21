// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ClientDomain",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "ClientDomain",
            targets: ["ClientDomain"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            from: "1.19.0"
        )
    ],
    targets: [
        .target(
            name: "ClientDomain",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "ClientDomainTests",
            dependencies: ["ClientDomain"]
        ),
    ]
)
