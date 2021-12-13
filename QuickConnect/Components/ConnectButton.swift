import SwiftUI
import SwiftOTP

struct ConnectButton: View {
	
	@Binding
	var credentials: Credentials
	
	@Binding
	var isRemembered: Bool
		
	@Binding
	var log: String
	
	@Binding
	var status: Status
	
	let keychain: Keychain
	let terminal: Terminal
	
	var body: some View {
		Button("Connect") {
			
			if isRemembered {
				keychain.save(credentials)
			} else {
				keychain.clear()
			}
			
			print("Connect")
            
            let data = base32DecodeToData(credentials.otp)!
            let code = TOTP(secret: data)!.generate(time: Date())!
			
            let input =
    """
    /opt/cisco/anyconnect/bin/vpn -s connect \(credentials.address) << "EOF"
    1
    \(credentials.username)
    \(credentials.password)\(code)
    y
    exit
    EOF
    """
            
			log.append("\n----------------------\n")
			
			status = .connecting
			terminal.run(input) { output in
				var output = output
				output.clean()
				log.append("\n\(output)")
			} completion: { result in
				status = .disconnected
				switch result {
				case .success(let string):
					if string.contains(">> state: Connected") {
						status = .connected
					}
				case .failure(_): print("Failed")
				}
			}
		}
	}
}
