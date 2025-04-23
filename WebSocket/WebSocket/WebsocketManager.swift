//
//  Untitled.swift
//  WebSocket
//
//  Created by shruti's macbook on 21/04/25.
//
import Combine
import Foundation

class WebSocketManager: ObservableObject {
    private var webSocketTask: URLSessionWebSocketTask?
    private let url = URL(string: "https://959f-2409-40d4-10c3-d5fd-d07f-f294-1d23-5016.ngrok-free.app/service/kite/instrument/list/nfo")!
    @Published var receivedMessage: String = ""
    let api = APIService()

    func connect() {
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        receiveMessage()
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }

    func send(message: String) {
        let message = URLSessionWebSocketTask.Message.string(message)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("Send error: \(error)")
            }
        }
    }

    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("Receive error: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    DispatchQueue.main.async {
                        self?.receivedMessage = text
                    }
                default:
                    print("Received unknown type")
                }
            }
            self?.receiveMessage()
        }
    }
    
    func connectApi() {
        api.fetchPost()
    }
    
}
