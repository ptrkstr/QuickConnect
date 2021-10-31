import SwiftUI
import SwiftOTP

struct ContentView: View {
	
	@State
	private var credentials: Credentials = .init()	
	
	@AppStorage("isRemembered")
	private var isRemembered: Bool = false
	
	@State
	private var log: String = "Log output..."
	
	@State
	private var status: Status = .disconnected
	
	@AppStorage("isLogShown")
	private var isLogShown: Bool = false
	
	private let keychain = Keychain()
	
	private let terminal = Terminal()
	
	var body: some View {
		VStack(spacing: 20) {
			InputForm(credentials: $credentials, status: $status, isRemembered: $isRemembered)
			VStack {
				HStack {
					Button(isLogShown ? "Hide Log" : "Show Log") {
						isLogShown.toggle()
					}
					DisconnectButton(status: $status, log: $log, terminal: terminal)
						.disabled(status != .connected)
					ConnectButton(credentials: $credentials, isRemembered: $isRemembered, log: $log, status: $status, keychain: keychain, terminal: terminal)
						.disabled(status != .disconnected || !credentials.isComplete)
				}
				StatusView(status: $status)
			}
			if isLogShown {
				Log(text: $log)
			}
		}
		.onAppear {
			if let credentials = keychain.retrieve() {
				self.credentials = credentials
			}
		}
		.onChange(of: isRemembered) { _ in
			if isRemembered == false {
				keychain.clear()
			}
		}
		.padding()
		.frame(minWidth: 300, alignment: .top)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
