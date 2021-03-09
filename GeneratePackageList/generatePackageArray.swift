#!/usr/bin/env swift

// Copyright © 2021 ZeeZide GmbH. All rights reserved.

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

func printHelp() {
	print("USAGE: ./generatePackageArray <packages-to-skip>")
	print("ARGUMENTS:")
	print("packages-to-skip: A comma separated list of packages to skip. \"tzdata\" is always included")
}

if CommandLine.argc > 1 && (CommandLine.arguments[1] == "-h" || CommandLine.arguments[1] == "--help") {
	printHelp()
	exit(0)
}

let data = try Data(contentsOf: URL(fileURLWithPath: "packages.json"))

let packageList = try JSONDecoder().decode([String].self, from: data)

let packagesToSkip: [String]
if CommandLine.arguments.count == 2 {
	packagesToSkip = CommandLine.arguments[1].components(separatedBy: ",")
} else {
	packagesToSkip = []
}

var output = ""

output += """
// Copyright © 2021 ZeeZide GmbH. All rights reserved.

// This file was generated using generatePackageArray.swift - DO NOT EDIT

var packageList = [\n
"""

for package in packageList {

	// Parse package string
	var name = ""
	var version = ""
	var release = ""

	let components = package.split(separator: "-")
	name = String(components[0])
	version = String(components[1])

	if Int(String(components[1][0])) == nil {
		name += "-" + components[1]
		version = String(components[2])
		release = components[3].replacingOccurrences(of: ".{ARCH}.rpm", with: "")
	} else {
		release = components[2].replacingOccurrences(of: ".{ARCH}.rpm", with: "")
	}

	// tzdata is interesting...
	if name != "tzdata" && !packagesToSkip.contains(name) {
		output += """
		Package(
			name: "\(name)",
			version: "\(version)",
			release: "\(release)"
		),\n
	"""	
	}
}

output += "]"

print("Generated Output:\n\n\(output)\n")

try output.data(using: .utf8)?.write(to: URL(fileURLWithPath: "Sources/GeneratePackageList/PackageList.swift"))

