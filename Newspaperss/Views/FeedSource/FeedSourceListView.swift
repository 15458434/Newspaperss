//
//  FeedSourceListView.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 29/07/2023.
//

import SwiftUI

struct FeedSourceListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \RSSFeedItem.url?.absoluteString, ascending: true)],
        animation: .default)
    private var items: FetchedResults<RSSFeedItem>
    
    var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            FeedSourceListDetailEditView(feedItem: item)
                        } label: {
                            if item.url?.absoluteString != nil {
                                Text(item.url!.absoluteString!)
                            } else {
                                Text("Invalid RSSFeed URL")
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .safeAreaInset(edge: .top, content: {
                    Spacer().frame(height: 60)
                })
                .overlay(FeedSourceTopBannerView().frame(maxWidth: .infinity, maxHeight: 60, alignment: .bottomTrailing), alignment: .top)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                .navigationTitle("Edit Feed")
            } else {
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            FeedSourceListDetailEditView(feedItem: item)
                        } label: {
                            if item.url?.absoluteString != nil {
                                Text(item.url!.absoluteString!)
                            } else {
                                Text("Invalid RSSFeed URL")
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .padding(.top, 80)
                .overlay(FeedSourceTopBannerView().frame(maxWidth: .infinity, maxHeight: 60, alignment: .bottomTrailing), alignment: .top)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                .navigationTitle("Edit Feed")
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = RSSFeedItem(context: viewContext)
            newItem.url = NSURL(string: "https://www.nu.nl/rss/Algemeen")
            newItem.sortValue = Double(items.count)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct FeedSourceListView_Previews: PreviewProvider {
    static var previews: some View {
        FeedSourceListView()
    }
}
