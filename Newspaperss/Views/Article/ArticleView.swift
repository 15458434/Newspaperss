//
//  ArticleView.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 30/07/2023.
//

import SwiftUI

struct ArticleView: View {
    @Environment(\.presentationMode) var presentationMode
    let feedItem: RSSFeedItemObject
    
    var body: some View {
        NavigationView {
            WebView(url: feedItem.link)
                .ignoresSafeArea()
                .navigationTitle(feedItem.title ?? "Article")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }

                }
            }
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var feedItem: RSSFeedItemObject {
        let new = RSSFeedItemObject()
        new.title = "Sarunw"
        new.link = URL(string: "https://sarunw.com/posts/swiftui-webview/")!
        return new
    }
    
    static var previews: some View {
        ArticleView(feedItem: feedItem)
    }
}
