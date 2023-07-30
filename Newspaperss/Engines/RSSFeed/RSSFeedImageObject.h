//
//  RSSFeedImageObject.h
//  Newspaperss
//
//  Created by Mark Cornelisse on 16/04/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

@import Foundation;
#import "RSSFeedParserDelegateReceiver.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSFeedImageObject : NSObject <RSSFeedParserDelegateReceiver>

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *link;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;

@end

NS_ASSUME_NONNULL_END
