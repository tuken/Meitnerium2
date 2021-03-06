// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Meitnerium2",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/noppoMan/Prorsum.git", from: "0.3.0"),
        .package(url: "https://github.com/noppoMan/SwiftKnex.git", from: "0.3.0"),
//        .package(url: "https://github.com/tuken/SwiftKnex.git", .branch("swift4")),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.0.0"),
        .package(url: "https://github.com/malcommac/SwiftMsgPack.git", from: "1.0.0"),
//        .package(url: "https://github.com/CryptoKitten/BCrypt.git", from: "0.13.0"),
        .package(url: "https://github.com/stormpath/Turnstile.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Meitnerium2",
            dependencies: ["SwiftKnex", "SwiftyJSON", "SwiftMsgPack", "Turnstile"]),
    ]
)
