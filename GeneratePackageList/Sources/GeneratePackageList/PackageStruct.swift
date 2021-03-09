// Copyright © 2021 ZeeZide GmbH. All rights reserved.

struct Package {
	init(name: String, version: String, release: String, filenameExtension: String = "rpm") {
		self.name = name
		self.version = version
		self.release = release
		self.filenameExtension = filenameExtension
	}

	let name: String
	let version: String
	let release: String
	var filenameExtension: String = "rpm"
}
