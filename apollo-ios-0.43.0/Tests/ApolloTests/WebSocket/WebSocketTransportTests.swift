import XCTest
import Apollo
import ApolloTestSupport
import Starscream
@testable import ApolloWebSocket

class WebSocketTransportTests: XCTestCase {

  private var webSocketTransport: WebSocketTransport!

  func testUpdateHeaderValues() {
    var request = URLRequest(url: TestURL.mockServer.url)
    request.addValue("OldToken", forHTTPHeaderField: "Authorization")

    self.webSocketTransport = WebSocketTransport(request: request)

    self.webSocketTransport.updateHeaderValues(["Authorization": "UpdatedToken"])

    XCTAssertEqual(self.webSocketTransport.websocket.request.allHTTPHeaderFields?["Authorization"], "UpdatedToken")
  }

  func testUpdateConnectingPayload() {
    WebSocketTransport.provider = MockWebSocket.self

    self.webSocketTransport = WebSocketTransport(request: URLRequest(url: TestURL.mockServer.url),
                                                 connectingPayload: ["Authorization": "OldToken"])

    let mockWebSocketDelegate = MockWebSocketDelegate()

    let mockWebSocket = self.webSocketTransport.websocket as? MockWebSocket
    self.webSocketTransport.socketConnectionState.mutate { $0 = .connected }
    mockWebSocket?.delegate = mockWebSocketDelegate

    let exp = expectation(description: "Waiting for reconnect")

    mockWebSocketDelegate.didReceiveMessage = { message in
      let json = try? JSONSerializationFormat.deserialize(data: message.data(using: .utf8)!) as? JSONObject
      guard let payload = json?["payload"] as? JSONObject, (json?["type"] as? String) == "connection_init" else {
        return
      }

      XCTAssertEqual(payload["Authorization"] as? String, "UpdatedToken")
      exp.fulfill()
    }

    self.webSocketTransport.updateConnectingPayload(["Authorization": "UpdatedToken"])
    self.webSocketTransport.initServer()

    waitForExpectations(timeout: 3, handler: nil)
  }

  func testCloseConnectionAndInit() {
    WebSocketTransport.provider = MockWebSocket.self

    self.webSocketTransport = WebSocketTransport(request: URLRequest(url: TestURL.mockServer.url),
                                                 connectingPayload: ["Authorization": "OldToken"])
    self.webSocketTransport.closeConnection()
    self.webSocketTransport.updateConnectingPayload(["Authorization": "UpdatedToken"])
    self.webSocketTransport.initServer()

    let exp = expectation(description: "Wait")
    let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
    if result == XCTWaiter.Result.timedOut {
    } else {
      XCTFail("Delay interrupted")
    }
  }
}

private final class MockWebSocketDelegate: WebSocketDelegate {
  
  var didReceiveMessage: ((String) -> Void)?

  func didReceive(event: WebSocketEvent, client: WebSocket) {
    switch event {
    case .text(let message):
      didReceiveMessage?(message)
    default:
      // No-op, this is a mock socket.
      break
    }
  }
}
