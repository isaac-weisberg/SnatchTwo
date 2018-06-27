// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "SnatchTwo",
    products: [
        .library(
            name: "SnatchTwo",
            targets: ["SnatchTwo"]),
    ],
    dependencies: [
        .package(url: "https://github.com/isaac-weisberg/Snatch.git", from: "4.0.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "SnatchTwo",
            dependencies: [ "Snatch", "RxSwift" ])
    ]
)
