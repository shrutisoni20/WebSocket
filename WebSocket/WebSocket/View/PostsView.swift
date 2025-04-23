//
//  PostsView.swift
//  WebSocket
//
//  Created by shruti's macbook on 23/04/25.
//
import Foundation
import SwiftUI

struct PostsView: View  {
    @StateObject private var apiService = APIService()
    @State private var receivedPosts: [Post] = []
    @State private var navigate = false
    
    var body: some View {
        NavigationStack {
            Button(action: {
                navigate = true
            }){
                Text("Tap me")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .navigationDestination(isPresented: $navigate){
                WebSocketView(apiService: apiService)
            }
            Group {
                List(receivedPosts, id: \.instrument_token) { post in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(post.name)
                            .font(.headline)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Posts")
        }
        .onAppear {
            apiService.fetchPost()
        }
        .onReceive(apiService.publisher){ results in
            receivedPosts = results
        }
    }
}

