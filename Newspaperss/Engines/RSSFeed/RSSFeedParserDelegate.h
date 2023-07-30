//
//  RSSFeedParserDelegate.h
//  Newspaperss
//
//  Created by Mark Cornelisse on 14/04/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

@import Foundation;
#import "RSSFeedChannelObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSFeedParserDelegate : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) RSSFeedChannelObject *channelData;

#pragma mark - NSObject

@end

NS_ASSUME_NONNULL_END
