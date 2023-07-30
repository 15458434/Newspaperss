//
//  RSSFeedChannelObject.h
//  Newspaperss
//
//  Created by Mark Cornelisse on 14/04/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

@import Foundation;
#import "RSSFeedParserDelegateReceiver.h"
#import "RSSFeedItemObject.h"
#import "RSSFeedImageObject.h"
#import "XMLElement.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSFeedChannelObject : NSObject <RSSFeedParserDelegateReceiver>

@property (nonatomic, strong, nullable) NSString *title;
//@property (nonatomic, strong, nullable) XMLElement *atom_LinkElement;
@property (nonatomic, strong, nullable) NSURL *link;
@property (nonatomic, strong, nullable) NSString *descriptionTag;
@property (nonatomic, strong, nullable) NSDate *lastBuildDate;
@property (nonatomic, strong, nullable) NSString *language;
@property (nonatomic, strong, nullable) NSString *syUpdatePeriod;
@property (nonatomic, strong, nullable) NSString *syUpdateFrequency;
@property (nonatomic, strong, nullable) NSString *generator;
@property (nonatomic, strong, nullable) RSSFeedImageObject *image;
@property (nonatomic, strong, nullable) XMLElement *site;
@property (nonatomic, strong, nullable, readonly) NSArray<RSSFeedItemObject *> *items;

- (void)addItem:(RSSFeedItemObject *)item;

- (void)removeCoronaRelatedItems;

#pragma mark - NSObject

@end

NS_ASSUME_NONNULL_END
