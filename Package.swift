// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Hue",
    platforms: [
        .iOS(.v8),
        .macOS(.v10_11),
        .tvOS(.v9),
    ],
    products: [
        .library(
            name: "HueAppKit",
            targets: ["HueAppKit"]),
        .library(
            name: "HueUIKit",
            targets: ["HueUIKit"]),
    ],
    targets: [
        .target(
            name: "HueAppKit",
            path: "Source/macOS"),
        .target(
            name: "HueUIKit",
            path: "Source/iOS+tvOS"),
    ],
    swiftLanguageVersions: [.v5]
)
