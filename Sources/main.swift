import Foundation
import Swifter
import Logger

let logger = Logger("main")

let server = HttpServer()
let cacheServer = CacheServer(server: server)
try server.start(8080)

logger.i("Server started on port \(try server.port)")
RunLoop.main.run()


if #available(macOS 10.15, *) {
    Task {
        do {
            let url = URL(string: "http://localhost:8080/cache/ip")!
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.httpBody = "data to store".data(using: .utf8)
            let data = try await URLSession.shared.data(for: request)
            print("received: \(String(data: data.0, encoding: .utf8).or(""))")
        } catch {
            print("Error: \(error)")
        }
    }
} else {
    // Fallback on earlier versions
}
