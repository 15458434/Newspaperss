//
//  RSSFeedItemObject.h
//  Newspaperss
//
//  Created by Mark Cornelisse on 15/04/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

@import Foundation;
#import "RSSFeedParserDelegateReceiver.h"
#import "XMLElement.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSFeedItemObject : NSObject <RSSFeedParserDelegateReceiver>

@property (nonatomic, strong, nullable) NSString *title;
@property (nonatomic, strong) NSURL *link;
@property (nonatomic, strong) NSURL *comments;
@property (nonatomic, strong, nullable) NSString *dcCreator;
@property (nonatomic, strong) NSDate *publicationDate;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) XMLElement *guid;
@property (nonatomic, strong) NSString *descriptionTag;
@property (nonatomic, strong) NSString *encoded;
@property (nonatomic, strong) NSURL *commentsRss;
@property (nonatomic, strong) NSString *slashComments;
@property (nonatomic, strong) NSString *postId;
@property (nonatomic, strong) XMLElement *content;

#pragma mark - NSObject

- (NSComparisonResult)compare:(RSSFeedItemObject *)other;

@end

NS_ASSUME_NONNULL_END
