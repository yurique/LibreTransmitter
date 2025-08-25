// swift-tools-version: 5.9
import PackageKit
let package = Package(
  name: "LibreTransmitterSPM",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "LibreTransmitter", targets: ["LibreTransmitter"]),
    .library(name: "LibreTransmitterPlugin", targets: ["LibreTransmitterPlugin"]),
  ],
  targets: [
    .target(name: "LibreTransmitter",
            path: "LibreTransmitter",
            resources: [.process("Resources")]),
    .target(name: "LibreTransmitterPlugin",
            dependencies: ["LibreTransmitter"],
            path: "LibreTransmitterPlugin")
  ]
)
