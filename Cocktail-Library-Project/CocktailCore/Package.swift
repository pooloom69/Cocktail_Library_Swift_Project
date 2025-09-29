// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CocktailCore",
    platforms: [
        .iOS(.v17), .macOS(.v13)
    ],
    products: [
        .library(name: "CocktailCore", targets: ["CocktailCore"])
    ],
    targets: [
        .target(name: "CocktailCore"),
        .testTarget(name: "CocktailCoreTests", dependencies: ["CocktailCore"])
    ]
)
