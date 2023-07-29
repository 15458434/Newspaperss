//
//  ContentView.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 29/07/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView() {
            FeedEditorView()
                .tabItem {
                    Label("News Feed", systemImage: "newspaper")
                }
            RSSListView()
                .tabItem {
                    Label("Edit Feed", systemImage: "timeline.selection")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
