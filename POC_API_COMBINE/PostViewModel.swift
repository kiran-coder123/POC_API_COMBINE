//
//  PostViewModel.swift
//  POC_API_COMBINE
//
//  Created by Kiran Sonne on 01/08/24.
//

import Foundation
import Combine
/*
   Scenario -
 1. sign up for monthly subscription for package to be delivered
 2. the company would make the package behind scene
 3. receive package at your door
 4. make sure the box isn't damaged
 5.open and make sure item is correct
 6. use the item
 7. cancellabel at any time
 */
class PostViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    var cancellable = Set<AnyCancellable>()
    init() {
         postsData()
    }
    func postsData(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // create a publisher
        // subscribe publisher on background thread
        // receive on main thread
        // tryMap (check that data is good)
        // decode data
        // sink( put the item into our app)
        // store (cancel subscription if needed)
        
        
        URLSession.shared.dataTaskPublisher(for: url)
          
           // .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> JSONDecoder.Input in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { completion in
                 print("COMPLETION: \(completion)")
            } receiveValue: { [weak self] postsData in
                self?.posts = postsData
            }
            .store(in: &cancellable)

    }
}
