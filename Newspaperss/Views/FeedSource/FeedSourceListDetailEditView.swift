//
//  FeedSourceListDetailEditView.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 29/07/2023.
//

import SwiftUI
import Shared

struct FeedSourceListDetailEditView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var feedItem: RSSFeedItem
    
    @State private var urlString: String = ""
    
    var body: some View {
        ZStack {
            TextFieldContainerView(text: $urlString)
                .background(Color("cellBackground"))
                .cornerRadius(6)
                .padding()
                .onAppear {
                    urlString = feedItem.url?.absoluteString ?? ""
                }
                .onDisappear {
                    do {
                        try viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
                .onChange(of: urlString) { newValue in
                    do {
                        let url = try transform(webUrlString: newValue)
                        feedItem.url = url as NSURL
                    } catch {
                        feedItem.url = nil
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("scrollViewBackground"))
        .navigationTitle("Enter RSS URL")
    }
}

struct FeedSourceListDetailEditView_Previews:
    PreviewProvider {
    static let persistence = PersistenceController(inMemory: true)
    
    static var feedItem: RSSFeedItem {
        let new = RSSFeedItem(context: persistence.container.viewContext)
        new.url = NSURL(string: "https://www.nu.nl/rss/Algemeen")
        return new
    }
    
    static var previews: some View {
        FeedSourceListDetailEditView(feedItem: feedItem)
    }
}
