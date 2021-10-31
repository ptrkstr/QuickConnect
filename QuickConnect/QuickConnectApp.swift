import SwiftUI

@main
struct QuickConnectApp: App {
	
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
            .windowStyle(HiddenTitleBarWindowStyle())
			.commands {
                CommandGroup(replacing: .newItem) {} // Hide - New Window - https://developer.apple.com/forums/thread/658243?answerId=635788022#635788022
				CommandGroup(after: .help) {
					Button("Source Code") {
						NSWorkspace.shared.open(.init(string: "https://github.com/ptrkstr/QuickConnect")!)
					}
				}
			}
    }
}
