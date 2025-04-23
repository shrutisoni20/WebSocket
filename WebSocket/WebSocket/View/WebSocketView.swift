//
//  ContentView.swift
//  WebSocket
//
//  Created by shruti's macbook on 18/04/25.
//

import SwiftUI
import CoreData
import Foundation

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct WebSocketView: View {
    @StateObject private var webSocketManager = WebSocketManager()
    @State private var messageToSend = ""
    @ObservedObject  var apiService : APIService
    var body: some View {
        VStack(spacing: 20) {
            Text("Received: \(webSocketManager.receivedMessage)")
                .padding()
            Text("\(apiService.posts.count)")
            TextField("Enter message", text: $messageToSend)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Send") {
                webSocketManager.send(message: messageToSend)
            }
            
            Button("Connect") {
                webSocketManager.connectApi()
            }
            
            Button("Disconnect") {
                webSocketManager.disconnect()
            }
        }
        .padding()
    }
}


