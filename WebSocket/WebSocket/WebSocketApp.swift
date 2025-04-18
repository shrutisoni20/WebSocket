//
//  WebSocketApp.swift
//  WebSocket
//
//  Created by shruti's macbook on 18/04/25.
//

import SwiftUI

@main
struct WebSocketApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
