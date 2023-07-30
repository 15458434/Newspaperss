//
//  FeedListModel.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 29/07/2023.
//

import Foundation
import SwiftUI
import Combine
import CoreData

final class FeedListModel: ObservableObject {
    let managedObjectContext: NSManagedObjectContext
    
    @Published private(set) var feedItemObjects = [RSSFeedItemObject]()
    @Published var coreDataError: Error?
    
    private var internalQueue = OperationQueue()
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func fetch() {
        internalQueue.cancelAllOperations()
        managedObjectContext.perform {
            let fetchRequest = RSSFeedItem.fetchRequest()
            fetchRequest.predicate = NSPredicate(value: true)
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \RSSFeedItem.sortValue, ascending: true)]
            do {
                let availableSources = try self.managedObjectContext.fetch(fetchRequest)
                let operations: [RSSFeedNetworkOperation] = availableSources.compactMap { $0.url as URL? }
                    .map { RSSFeedNetworkOperation(url: $0) }
                let finalOperation = BlockOperation {
                    debugPrint("All rssfeedfetches are done.")
                    let results = operations.compactMap { $0.result }
                        .compactMap { fetchedResult -> RSSFeedChannelObject? in
                        switch fetchedResult {
                        case .success(let channelObject):
                            return channelObject
                        case .failure(_):
                            return nil
                        case .none:
                            return nil
                        }
                    }
                        .compactMap({ channelObject in
                            return channelObject.items
                        })
                        .flatMap { $0 }
                        .sorted { one, two in
                            let comparisonResult = one.compare(two)
                            switch comparisonResult {
                            case ComparisonResult.orderedAscending:
                                 return true
                            default:
                                return false
                            }
                        }
                    
                    DispatchQueue.main.async {
                        self.feedItemObjects = results
                    }
                }
                operations.forEach { networkOperation in
                    finalOperation.addDependency(networkOperation)
                    self.internalQueue.addOperation(networkOperation)
                }
                self.internalQueue.addOperation(finalOperation)
            } catch {
                DispatchQueue.main.async {
                    self.coreDataError = error
                }
            }
        }
    }
    
    // MARK: ObservableObject
}
