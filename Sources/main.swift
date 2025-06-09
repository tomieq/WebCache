import Foundation
import Swifter
import Logger

let logger = Logger("main")

let server = HttpServer()

server.name = "WebCache"
server.requestBodyLimit = .limit(.KB(250))

let cacheServer = CacheServer(server: server)
try server.start(8080)

logger.i("Server started on port \(try server.port)")
RunLoop.main.run()
