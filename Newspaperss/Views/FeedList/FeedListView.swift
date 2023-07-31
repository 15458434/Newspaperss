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
            if #available(iOS 15.0, *) {
                ScrollView {
                    scrollViewContent
                }
                .navigationTitle("News Feed")
                .background(Color("scrollViewBackground"))
                .safeAreaInset(edge: .top, spacing: 0) {
                    adBanner
                }
                .onAppear {
                    feedListModel.fetch()
                }
            } else {
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
                        }
                    }
                    .padding(.top, 60.0)
                    .background(Color("scrollViewBackground"))
                }
                .navigationTitle("News Feed")
                .overlay(FeedListTopBannerView().frame(maxWidth: .infinity, maxHeight: 60, alignment: .bottomTrailing), alignment: .top)
                .onAppear {
                    feedListModel.fetch()
                }
            }
        }
    }
    
    var scrollViewContent: some View {
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
            }
        }
        .background(Color("scrollViewBackground"))
    }
    
    var adBanner: some View {
        FeedListTopBannerView().frame(maxWidth: .infinity, maxHeight: 60, alignment: .top)
            .background(Color("scrollViewBackground"))
    }
}

struct FeedListView_Previews: PreviewProvider {
    static let persistence = PersistenceController.preview
    
    static var previews: some View {
        FeedListView(feedListModel: FeedListModel(managedObjectContext: persistence.container.newBackgroundContext()))
    }
}
