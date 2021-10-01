import SwiftUI

struct Header: View {
	
	var body: some View {
		HStack(alignment: .top, spacing: 10) {
			Image("logo")
			VStack(alignment: .leading, spacing: 4) {
				Text("QuickConnect")
					.font(.title)
				Text("QuickConnect persists all your credentials to the keychain and automatically inputs them when initiating a Cisco AnyConnect VPN session. You can view the source code in the help tab from the menu.")
			}
				.frame(maxWidth: 300)
		}
	}
}
