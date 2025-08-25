// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "LibreTransmitter",
    defaultLocalization: "en",
    platforms: [.iOS("15.0")],
    products: [
        .library(name: "LibreTransmitter", targets: ["LibreTransmitter"]),
        .library(name: "LibreTransmitterUI", targets: ["LibreTransmitterUI"]),
    ],
    dependencies: [
        .package(
           url: "https://github.com/LoopKit/LoopKit",
           branch: "dev"
        )
    ],
    targets: [
        .binaryTarget(
            name: "RawGlucose",
            path: "RawGlucose.xcframework"
        ),

        .target(name: "Common", path: "Common"),
        .target(name: "Bluetooth", dependencies: ["Common"], path: "Bluetooth"),
        .target(name: "LibreSensor", dependencies: ["Common", "Bluetooth"], path: "LibreSensor"),

        .target(
            name: "LibreTransmitter",
            dependencies: [
                "Common", "Bluetooth", "LibreSensor", "RawGlucose",
                .product(name: "LoopKit", package: "LoopKit"),
                .product(name: "LoopKitUI", package: "LoopKit")
            ],
            path: "LibreTransmitter"
        ),

        .target(
            name: "LibreTransmitterUI",
            dependencies: [
                "LibreTransmitter",
                .product(name: "LoopKit", package: "LoopKit"),
                .product(name: "LoopKitUI", package: "LoopKit")
            ],
            path: "LibreTransmitterUI"
        ),
    ]
)