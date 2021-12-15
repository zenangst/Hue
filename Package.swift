// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Hue",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_11),
        .tvOS(.v9),
    ],
    products: [
        .library(
            name: "Hue",
            targets: ["Hue"]),
    ],
    targets: [
        .target(
            name: "Hue",
            path: "Source"),
    ],
    swiftLanguageVersions: [.v5]
)
