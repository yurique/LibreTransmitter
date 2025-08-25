// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "LibreTransmitterSPM",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],

    dependencies: [
            .package(url: "https://github.com/LoopKit/LoopKit.git", branch: "dev")
    ],

    products: [
        .library(name: "LibreTransmitter", targets: ["LibreTransmitter"]),
        .library(name: "LibreTransmitterUI", targets: ["LibreTransmitterUI"]),
    ],

    targets: [
        .binaryTarget(
            name: "RawGlucose",
            path: "RawGlucose.xcframework"
        ),

        .target(name: "Common", path: "Common"),
        .target(name: "Bluetooth", dependencies: ["Common"], path: "Bluetooth"),
        .target(name: "LibreSensor", dependencies: ["Common","Bluetooth"], path: "LibreSensor"),

        .target(
            name: "LibreTransmitter",
            dependencies: [
                "Common",
                "Bluetooth",
                "LibreSensor",
                "RawGlucose",
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