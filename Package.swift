// swift-tools-version:5.7
import PackageDescription

let name = "HelloWorld"
let package = Package(
  name: name,
  platforms: [.macOS(.v13)],
  targets: [
    .executableTarget(name: name, path: "")
  ]
)
