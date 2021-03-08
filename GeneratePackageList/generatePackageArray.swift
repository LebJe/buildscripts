#!/usr/bin/env swift

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

let packageList = [
	"gcc-7.3.1-6.amzn2.0.4.aarch64.rpm",
	"gcc-c++-7.3.1-6.amzn2.0.4.aarch64.rpm",
	"libgcc-7.3.1-6.amzn2.0.4.aarch64.rpm",
	"glibc-2.26-34.amzn2.aarch64.rpm",
	"glibc-static-2.26-34.amzn2.aarch64.rpm",
	"glibc-devel-2.26-34.amzn2.aarch64.rpm",
	"glibc-headers-2.26-34.amzn2.aarch64.rpm",
	"kernel-headers-4.14.181-140.257.amzn2.aarch64.rpm",
	"libicu-50.2-4.amzn2.aarch64.rpm",
	"libicu-devel-50.2-4.amzn2.aarch64.rpm",
	"zlib-devel-1.2.7-18.amzn2.aarch64.rpm",
	"libuuid-2.30.2-2.amzn2.0.4.aarch64.rpm",
	"libuuid-devel-2.30.2-2.amzn2.0.4.aarch64.rpm",
	"libedit-devel-3.0-12.20121213cvs.amzn2.0.2.aarch64.rpm",
	"libxml2-static-2.9.1-6.amzn2.3.3.aarch64.rpm",
	"libxml2-devel-2.9.1-6.amzn2.3.3.aarch64.rpm",
	"sqlite-devel-3.7.17-8.amzn2.1.1.aarch64.rpm",
	"python-devel-2.7.18-1.amzn2.aarch64.rpm",
	"ncurses-static-6.0-8.20170212.amzn2.1.3.aarch64.rpm",
	"ncurses-devel-6.0-8.20170212.amzn2.1.3.aarch64.rpm",
	"libcurl-devel-7.61.1-12.amzn2.0.1.aarch64.rpm",
	"openssl-static-1.0.2k-19.amzn2.0.3.aarch64.rpm",
	"openssl-devel-1.0.2k-19.amzn2.0.3.aarch64.rpm",
	"tzdata-2019c-1.amzn2.noarch.rpm",
	"libtool-2.4.2-22.2.amzn2.0.2.aarch64.rpm",
	"lua-devel-5.1.4-15.amzn2.0.2.aarch64.rpm",
	"lua-static-5.1.4-15.amzn2.0.2.aarch64.rpm",
	"libpng-devel-1.5.13-7.amzn2.0.2.aarch64.rpm",
	"libpng-static-1.5.13-7.amzn2.0.2.aarch64.rpm",
	"libtiff-devel-4.0.3-32.amzn2.aarch64.rpm",
	"libtiff-static-4.0.3-32.amzn2.aarch64.rpm",
	"libuv-devel-1.23.2-1.amzn2.0.2.aarch64.rpm",
	"libuv-static-1.23.2-1.amzn2.0.2.aarch64.rpm",
	"lz4-devel-1.7.5-2.amzn2.0.1.aarch64.rpm",
	"lz4-static-1.7.5-2.amzn2.0.1.aarch64.rpm",
	"pcre2-devel-10.23-2.amzn2.0.2.aarch64.rpm",
	"pcre2-static-10.23-2.amzn2.0.2.aarch64.rpm",
	"popt-devel-1.13-16.amzn2.0.2.aarch64.rpm",
	"popt-static-1.13-16.amzn2.0.2.aarch64.rpm",
	"postgresql-devel-9.2.24-1.amzn2.0.1.aarch64.rpm",
	"postgresql-static-9.2.24-1.amzn2.0.1.aarch64.rpm",
	"zlib-static-1.2.7-18.amzn2.aarch64.rpm",
	"libxml2-2.9.1-6.amzn2.3.3.aarch64.rpm",
	"sqlite-3.7.17-8.amzn2.1.1.aarch64.rpm",
	"libedit-3.0-12.20121213cvs.amzn2.0.2.aarch64.rpm",
	"ncurses-libs-6.0-8.20170212.amzn2.1.3.aarch64.rpm",
	"libcurl-7.61.1-12.amzn2.0.1.aarch64.rpm",
	"openssl-libs-1.0.2k-19.amzn2.0.3.aarch64.rpm",
	"lua-5.1.4-15.amzn2.0.2.aarch64.rpm",
	"libpng-1.5.13-7.amzn2.0.2.aarch64.rpm",
	"lz4-1.7.5-2.amzn2.0.1.aarch64.rpm",
	"pcre2-10.23-2.amzn2.0.2.aarch64.rpm",
	"popt-1.13-16.amzn2.0.2.aarch64.rpm",
	"postgresql-libs-9.2.24-1.amzn2.0.1.aarch64.rpm",
	"zlib-1.2.7-18.amzn2.aarch64.rpm"
]

if CommandLine.argc < 2 {
	print("USAGE: ./generatePackageArray <arch: x86_64 or aarch64>")
	exit(1)
}

let arch = CommandLine.arguments[1]

switch arch {
	case "x86_64":
		break
	case "aarch64":
		break
	default: 
		print("Invalid value for <arch>: \"\(arch)\"")
		exit(2)
}

print("""
// This file was generated using generatePackageArray.swift - DO NOT EDIT

var packageList = [
""")

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
		release = components[3].replacingOccurrences(of: ".\(arch).rpm", with: "")
	} else {
		release = components[2].replacingOccurrences(of: ".\(arch).rpm", with: "")
	}


	let str = """
		Package(
			name: "\(name)",
			version: "\(version)",
			release: "\(release)"
		),
	"""

	// tzdata is interesting...
	if name != "tzdata" {
		print(str)
	}

}

print("]")
