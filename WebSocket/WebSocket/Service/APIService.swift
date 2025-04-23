//
//  APIService.swift
//  WebSocket
//
//  Created by shruti's macbook on 21/04/25.

import Foundation
import SwiftUI
import Combine

class APIService : ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published var posts : [Post] = []
    let publisher =  PassthroughSubject<[Post],Never>()
   
    func fetchPost() {
        let url = URL(string: "https://c2ec-2409-40d4-10c3-d5fd-d187-c176-cd2a-9691.ngrok-free.app/service/kite/instrument/list/nfo")!

        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map{$0.data}
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    print(result)
                case .failure(let error):
                    print(error)
                }
            }, receiveValue:  { posts in
                print("value is \(posts)")
                self.publisher.send(posts)
                self.posts = posts
            })
          .store(in: &cancellables)
    }
}
