//
//  FeedListView.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 29/07/2023.
//

import SwiftUI

struct FeedListView: View {
    @StateObject var feedListModel: FeedListModel
    
    @State private var isPresentingArticleView = false
    
    @State private var items = [RSSFeedItemObject]()
    
    var body: some View {
        NavigationView {
            ScrollView {
                scrollViewContent
            }
            .refreshable {
                feedListModel.fetch()
            }
            .noDataPlaceHolder(items.isEmpty, placeHolderContent: {
                ScrollView {
                    emptyMessage
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            })
            .navigationTitle("News Feed")
            .background(Color("scrollViewBackground"))
            .safeAreaInset(edge: .top, spacing: 0) {
                adBanner
            }
            .onReceive(feedListModel.$feedItemObjects, perform: { newValue in
                items = newValue
            })
            .onAppear {
                feedListModel.fetch()
            }
        }
    }
    
    var scrollViewContent: some View {
        LazyVStack(alignment: .leading, spacing: 6) {
            ForEach(items, id: \RSSFeedItemObject.self) { feedListObject in
                Button {
                    isPresentingArticleView = true
                } label: {
                    FeedListItemView(item: feedListObject)
                        .padding([.top, .leading, .trailing])
                }
                .sheet(isPresented: $isPresentingArticleView) {
                    ArticleView(feedItem: feedListObject)
                }
            }
        }
        .background(Color("scrollViewBackground"))
    }
    
    var adBanner: some View {
        FeedListTopBannerView().frame(maxWidth: .infinity, maxHeight: 60, alignment: .top)
            .background(Color("scrollViewBackground"))
    }
    
    var emptyMessage: some View {
        VStack {
            Image(systemName: "timeline.selection")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding([.bottom])
            Text("No RSS Feed selected")
            Text("Go to the Edit Feed Tab to add RSS Feeds")
        }
        .foregroundColor(Color("scrollEmptyMessage"))
    }
}

struct FeedListView_Previews: PreviewProvider {
    static let persistence = PersistenceController.preview
    
    static var previews: some View {
        FeedListView(feedListModel: FeedListModel(managedObjectContext: persistence.container.newBackgroundContext()))
    }
}
