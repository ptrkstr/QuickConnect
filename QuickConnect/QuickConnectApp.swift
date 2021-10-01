import SwiftUI

@main
struct QuickConnectApp: App {
	
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
			.windowStyle(HiddenTitleBarWindowStyle())
			.commands {
				CommandGroup(after: .help) {
					Button("Source Code") {
						NSWorkspace.shared.open(.init(string: "https://github.com/ptrkstr/QuickConnect")!)
					}
				}
			}
    }
}
