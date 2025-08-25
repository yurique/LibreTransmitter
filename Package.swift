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
        // Prebuilt binary
        .binaryTarget(
            name: "RawGlucose",
            path: "RawGlucose.xcframework"
        ),

        // Internal code modules (one per folder)
        .target(name: "Common", path: "Common"),
        .target(name: "Bluetooth", dependencies: ["Common"], path: "Bluetooth"),
        .target(name: "LibreSensor", dependencies: ["Common","Bluetooth"], path: "LibreSensor"),

        // Main library
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
            // resources: [.process("Resources")] // add if you have bundled assets
        ),

        // UI library
        .target(
            name: "LibreTransmitterUI",
            dependencies: [
                "LibreTransmitter",
                .product(name: "LoopKit", package: "LoopKit"),
                .product(name: "LoopKitUI", package: "LoopKit")
            ],
            path: "LibreTransmitterUI"
            // resources: [.process("Resources")]
        ),
    ]
)