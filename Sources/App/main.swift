import Vapor
import HTTP

let drop = Droplet()

drop.get("/") { request in
    return "Hellow World! I'm GithubShokunin!"
}

try WebSocketManager.shared.connectWebSocket()

drop.run()
