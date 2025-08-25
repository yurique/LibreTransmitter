// swift-tools-version: 5.9
import PackageKit
let package = Package(
  name: "LibreTransmitterSPM",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "LibreTransmitter", targets: ["LibreTransmitter"]),
    .library(name: "RawGlucose", targets: ["RawGlucose"]),
  ],
  targets: [
    .target(name: "RawGlucose",
            path: "RawGlucose"),
    .target(name: "LibreTransmitter",
            dependencies: ["RawGlucose"],
            path: "LibreTransmitter")
  ]
)
