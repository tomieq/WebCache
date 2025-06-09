import Swifter
import Logger
import SwiftExtensions

class CacheServer {
    private let server: HttpServer
    private let logger: Logger
    private var cache: [String: String]
    
    init(server: HttpServer) {
        self.server = server
        self.logger = Logger(CacheServer.self)
        self.cache = [:]
        
        server.put["cache/:key"] = self.store
        server.post["cache/:key"] = self.store
        
        server.get["cache/:key"] = { request, _ in
            guard let key = request.pathParams.get("key"),
                  let value = self.cache[key] else {
                      return .notFound(nil)
            }
            return .ok(.jsonString(value))
        }
    }
    
    private func store(_ request: HttpRequest, _ headers: HttpResponseHeaders) -> HttpResponse {
        guard let key = request.pathParams.get("key"),
        let value = request.body.string, value.isEmpty.not else {
            return .badRequest(nil)
        }
        self.cache[key] = value
        logger.i("stored value for key: \(key)")
        return .created(.jsonString(value))
    }
}
