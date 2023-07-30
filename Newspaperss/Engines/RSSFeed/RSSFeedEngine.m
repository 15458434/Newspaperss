//
//  RSSFeedEngine.m
//  Newspaperss
//
//  Created by Mark Cornelisse on 14/04/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

#import "RSSFeedEngine.h"
#import "RSSFeedParserDelegate.h"

@interface RSSFeedEngine ()

@property (nonatomic, strong) NSXMLParser *xmlParser;
@property (nonatomic, strong) RSSFeedParserDelegate *xmlParserDelegate;

@end

@implementation RSSFeedEngine

- (RSSFeedChannelObject *)parseData:(NSData *)data {
    _xmlParserDelegate = [[RSSFeedParserDelegate alloc] init];
    _xmlParser = [[NSXMLParser alloc] initWithData:data];
    _xmlParser.delegate = _xmlParserDelegate;
    _xmlParser.shouldResolveExternalEntities = NO;
    _xmlParser.shouldProcessNamespaces = YES;
    _xmlParser.shouldReportNamespacePrefixes = NO;
    [_xmlParser parse];
    _channel = _xmlParserDelegate.channelData;
    return _xmlParserDelegate.channelData;
}

#pragma mark - NSObject

@end
