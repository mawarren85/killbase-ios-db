// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "reminders",
    products: [
        .library(name: "reminders", targets: ["reminders"]),
        .executable(name: "reminders", targets: ["reminders"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "2.1.0")),
        .package(url: "https://github.com/vapor/fluent-provider.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/vapor-community/postgresql-provider.git", .upToNextMajor(from: "2.1.0")),
    ],
    targets: [
        .target(
            name: "reminders",
            dependencies: ["Vapor", "FluentProvider", "PostgreSQLProvider"],
            path: "Sources",
            exclude: ["Config", "Public", "Resources"]
        )
    ]
)
