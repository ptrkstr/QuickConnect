import Foundation

extension String {
	
	mutating func clean() {
		var strings = [String]()
		enumerateLines { line, _ in
			let line = line.trimmingCharacters(in: .whitespacesAndNewlines)
			if line.isEmpty == false {
				strings.append(line)
			}
		}
		self = strings.joined(separator: "\n")
	}
}
