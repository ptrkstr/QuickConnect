import SwiftUI

struct Log: View {
	
	@Binding
	var text: String
	
	private let scrollID = "scrollID"
	
	var body: some View {
		VStack(alignment: .trailing) {
			ScrollView(.vertical) {
				ScrollViewReader { proxy in
					Text(text)
						.frame(maxWidth: .infinity, alignment: .topLeading)
						.padding()
						.lineLimit(nil)
						.id(scrollID)
						.onChange(of: text) { _ in
							withAnimation {
								proxy.scrollTo(scrollID, anchor: .bottom)
							}
						}
					
				}
			}
				.frame(minHeight: 200)
				.background(Color(.textBackgroundColor))
				.cornerRadius(10)
			Button("Copy Log to Clipboard") {
				let pasteboard = NSPasteboard.general
				pasteboard.declareTypes([.string], owner: nil)
				pasteboard.setString(text, forType: .string)
			}
		}
			
	}
	
}

