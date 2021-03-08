//
//  PackageStruct.swift
//  
//
//  Created by Jeff Lebrun on 3/8/21.
//

struct Package {
	init(name: String, version: String, release: String, arch: String = "x86_64", filenameExtension: String = "rpm") {
		self.name = name
		self.version = version
		self.release = release
		self.arch = arch
		self.filenameExtension = filenameExtension
	}

	let name: String
	let version: String
	let release: String
	var arch: String = "x86_64"
	var filenameExtension: String = "rpm"
}
