import SwiftUI

struct InputForm: View {
	
	@Binding
	var credentials: Credentials
	
	@Binding
	var status: Status
	
	@Binding
	var isRemembered: Bool
	
	var body: some View {
		Form {
			TextField("", text: $credentials.address)
				.formLabel(Text("Address:"))
			TextField("", text: $credentials.username)
				.formLabel(Text("Username:"))
			SecureField("", text: $credentials.password)
				.formLabel(Text("Password:"))
			Toggle("", isOn: $isRemembered)
				.formLabel(Text("Remember:"))
		}
			.disabled(status != .disconnected)
	}
}
