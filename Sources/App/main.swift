import Vapor
import HTTP

let drop = Droplet()

try WebSocketManager.shared.connectWebSocket()

drop.run()
