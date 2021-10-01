import SwiftUI

struct StatusView: View {
	
	@Binding
	var status: Status
	
	var statusString: String {
		switch status {
		case .connected:
			return "Connected"
		case .connecting:
			return "Connecting"
		case .disconnecting:
			return "Disconnecting"
		case .disconnected:
			return "Disconnected"
		}
	}
	
	var body: some View {
		HStack(spacing: 4) {
			Text(statusString)
			Group {
				switch status {
				case .connected:
					Circle()
						.frame(width: 10, height: 10)
						.foregroundColor(Color(.green))
				case .connecting:
					ProgressView()
						.scaleEffect(0.5, anchor: .center)
				case .disconnecting:
					ProgressView()
						.scaleEffect(0.5, anchor: .center)
				case .disconnected:
					Circle()
						.frame(width: 10, height: 10)
						.foregroundColor(Color(.red))
				}
			}
			.frame(width: 20, height: 20)
		}
	}
	
}

struct StatusView_Previews: PreviewProvider {
	static var previews: some View {
		StatusView(status: .constant(.connecting))
		StatusView(status: .constant(.connected))
	}
}
