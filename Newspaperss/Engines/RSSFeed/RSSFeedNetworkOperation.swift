//
//  RSSFeedNetworkOperation.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 29/07/2023.
//

import Foundation
import Combine

final class RSSFeedNetworkOperation: Operation {
    let session: URLSession
    let url: URL
    
    private(set) var result: Result<RSSFeedChannelObject?, Error>?
    
    private var bag = Set<AnyCancellable>()
    
    init(session: URLSession? = nil, url: URL) {
        if let session {
            self.session = session
        } else {
            self.session = URLSession.shared
        }
        self.url = url
        super.init()
    }
    
    // MARK: Operation
    
    override func main() {
        let group = DispatchGroup()
        
        group.enter()
        session.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .map{ RSSFeedEngine().parseData($0) }
            .eraseToAnyPublisher()
            .sink(
                receiveCompletion: { status in
                    switch status {
                    case .finished:
                        debugPrint("Completed")
                        break
                    case .failure(let error):
                        self.result = .failure(error)
                        break
                    }
                    group.leave()
                },
                receiveValue: { channelObject in
                    self.result = .success(channelObject)
                }
            )
            .store(in: &bag)
        
        group.wait()
    }
    
    override func cancel() {
        bag.removeAll()
        super.cancel()
    }
}
