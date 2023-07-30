//
//  RSSFeedEngine.h
//  Newspaperss
//
//  Created by Mark Cornelisse on 14/04/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

@import Foundation;
#import "RSSFeedChannelObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSFeedEngine : NSObject

@property (nonatomic, strong, nullable) RSSFeedChannelObject *channel;

- (RSSFeedChannelObject *)parseData:(NSData *)data;

#pragma mark - NSObject

@end

NS_ASSUME_NONNULL_END
