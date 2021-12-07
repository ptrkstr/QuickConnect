struct Credentials: Codable {
	
	var isComplete: Bool {
		[address, username, password].contains("") == false
	}
	
	var address: String = ""
	var username: String = ""
	var password: String = ""
}
