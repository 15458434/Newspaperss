//
//  ContentView.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 29/07/2023.
//

import SwiftUI
import CoreData
import GoogleMobileAds

struct ContentView: View {
    @State var googleAdapterState: GADAdapterStatus?
    
    var body: some View {
        TabView() {
            FeedListView(feedListModel: FeedListModel(managedObjectContext: PersistenceController.shared.container.newBackgroundContext()))
                .tabItem {
                    Label("News Feed", systemImage: "newspaper")
                }
            FeedSourceListView()
                .tabItem {
                    Label("Edit Feed", systemImage: "timeline.selection")
                }
        }
        .environment(\.googleAdapterState, nil)
        .onReceive(GADMobileAds.sharedInstance().initializationStatus.publisher(for: \.adapterStatusesByClassName), perform: { adapterStatusesByClassName in
            debugPrint("status: \(adapterStatusesByClassName)")
            self.googleAdapterState = adapterStatusesByClassName["GADMobileAds"]
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
