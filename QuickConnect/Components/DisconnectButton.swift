import SwiftUI

struct DisconnectButton: View {
	
	@Binding
	var status: Status
	
	@Binding
	var log: String
	
	let terminal: Terminal
	
	var body: some View {
		Button("Disconnect") {
			
			let input = "/opt/cisco/anyconnect/bin/vpn disconnect"
			
			log.append("\n----------------------\n")
			
			status = .disconnecting
			terminal.run(input) { output in
				var output = output
				output.clean()
				log.append("\n\(output)")
			} completion: { result in
				status = .connected
				switch result {
				case .success(let string):
					if string.contains(">> state: Disconnected") {
						status = .disconnected
					}
				case .failure(_): print("Failed")
				}
			}
		}
	}
}
