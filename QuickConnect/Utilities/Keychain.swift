import Foundation
import Valet

struct Keychain {
	
	private let valet = Valet.valet(with: .init(nonEmpty: "aa665593-90c1-49d5-8b4f-830b4459b1d1")!, accessibility: .whenUnlockedThisDeviceOnly)
	private let key = "credentials"
	
	func save(_ credentials: Credentials) {
		let data = try! JSONEncoder().encode(credentials)
		try! valet.setObject(data, forKey: key)
	}
	
	func clear() {
		try! valet.removeObject(forKey: key)
	}
	
	func retrieve() -> Credentials? {
		guard let data = try? valet.object(forKey: key) else { return nil }
		return try! JSONDecoder().decode(Credentials.self, from: data)
	}
}
