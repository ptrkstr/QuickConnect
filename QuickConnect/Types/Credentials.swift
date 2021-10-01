struct Credentials: Codable {
	
	var isComplete: Bool {
		[address, username, password, otp].contains("") == false
	}
	
	var address: String = ""
	var username: String = ""
	var password: String = ""
	var otp: String = ""
}
