//
//  FeedListItemView.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 29/07/2023.
//

import SwiftUI

struct FeedListItemView: View {
    let item: RSSFeedItemObject
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6, content: {
                Text(item.title ?? "")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Text(item.descriptionTag)
                    .font(.subheadline)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
                    .multilineTextAlignment(.leading)
            })
            Spacer()
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(6)
    }
}

struct FeedListItemView_Previews: PreviewProvider {
    static var item: RSSFeedItemObject {
        let new = RSSFeedItemObject()
        new.title = "Test"
        new.descriptionTag = "I'm baby prism tofu pabst food truck, plaid XOXO flannel normcore man braid cornhole marfa solarpunk single-origin coffee aesthetic. Pinterest shoreditch vibecession copper mug pickled coloring book. Hexagon gastropub DIY franzen normcore vibecession. Readymade fanny pack meh farm-to-table organic flannel pickled jawn mukbang blue bottle prism chambray ethical trust fund. Ugh wolf ascot, man bun tousled echo park ethical woke tonx humblebrag cupping chillwave schlitz. Gorpcore lumbersexual meggings squid, hella wayfarers tumeric +1 austin vinyl before they sold out pop-up church-key."
        return new
    }
    static var previews: some View {
        FeedListItemView(item: item)
    }
}
