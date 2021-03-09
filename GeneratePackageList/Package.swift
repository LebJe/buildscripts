// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "GeneratePackageList",
    dependencies: [
		.package(name: "GRDB", url: "https://github.com/groue/GRDB.swift.git", from: "5.5.0"),
    ],
    targets: [
        .target(
            name: "GeneratePackageList",
            dependencies: [
				"GRDB"
			]
		),
        .testTarget(
            name: "GeneratePackageListTests",
            dependencies: ["GeneratePackageList"]
		),
    ]
)
