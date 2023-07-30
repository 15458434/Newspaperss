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
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 6) {
                    ForEach(feedListModel.feedItemObjects, id: \RSSFeedItemObject.self) { feedListObject in
                        Button {
                            isPresentingArticleView = true
                        } label: {
                            FeedListItemView(item: feedListObject)
                                .padding([.top, .leading, .trailing])
                        }
                        .sheet(isPresented: $isPresentingArticleView) {
                            ArticleView(feedItem: feedListObject)
                        }

//                        NavigationLink {
//                            ArticleView(feedItem: feedListObject)
//                        } label: {
//                            FeedListItemView(item: feedListObject)
//                                .padding([.top, .leading, .trailing])
//                        }
                    }
                }
                .background(Color("scrollViewBackground"))
            }
            .navigationTitle("News Feed")
            .onAppear {
                feedListModel.fetch()
            }
        }
    }
}

struct FeedListView_Previews: PreviewProvider {
    static let persistence = PersistenceController.preview
    
    static var previews: some View {
        FeedListView(feedListModel: FeedListModel(managedObjectContext: persistence.container.newBackgroundContext()))
    }
}
