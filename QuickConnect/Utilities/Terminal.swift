import Foundation
import Combine


struct Terminal {
	
//	@Published
//	private(set) var output: String = ""
	
	private let center = NotificationCenter.default
	
	// https://stackoverflow.com/a/55196475/4698501
	func run(_ command: String, output: @escaping ((String) -> ()), completion: @escaping ((Result<String, Error>) -> Void)) {
		
		var allOutput = ""
		
		let task = Process()
		let outputPipe = Pipe()
		let errorPipe = Pipe()
		
		task.standardOutput = outputPipe
		task.standardError = errorPipe
		task.arguments = ["-c", command]
		task.launchPath = "/bin/zsh"
		task.terminationHandler = { returnedTask in
			center.removeObserver(
				self,
				name: FileHandle.readCompletionNotification,
				object: outputPipe.fileHandleForReading
			)
			let status = returnedTask.terminationStatus
			
			if status == 0 {
				DispatchQueue.main.async {
					completion(.success(allOutput))
				}
			} else {
				let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
				let errorString = String(data: errorData, encoding: .utf8)!
				DispatchQueue.main.async {
					output(errorString)
					allOutput.append("\n\(errorString)")
					completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorString])))
				}
			}
		}
		let outputHandle = outputPipe.fileHandleForReading
		center.addObserver(
			forName: FileHandle.readCompletionNotification,
			object: outputHandle,
			queue: .main
		) { notification in
			if let data = notification.userInfo?[NSFileHandleNotificationDataItem] as? Data, !data.isEmpty {
				let string = String(data: data, encoding: . utf8)!
				output(string)
				allOutput.append("\n\(string)")
			} else {
				task.terminate()
				return
			}
			outputHandle.readInBackgroundAndNotify()
		}
		outputHandle.readInBackgroundAndNotify()
		task.launch()
	}
	
}
