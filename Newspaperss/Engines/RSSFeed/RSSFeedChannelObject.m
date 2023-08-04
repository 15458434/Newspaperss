//
//  RSSFeedChannelObject.m
//  Newspaperss
//
//  Created by Mark Cornelisse on 14/04/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

#import "RSSFeedChannelObject.h"
#import "XMLElement.h"

@interface RSSFeedChannelObject ()

@property (nonatomic, strong, nullable) NSMutableArray<RSSFeedItemObject *> *items;

@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *currentElementAttributeDictionary;
@property (nonatomic, strong) NSString *currentElement;

@end

@implementation RSSFeedChannelObject

- (void)addItem:(RSSFeedItemObject *)item {
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    [_items addObject:item];
}

#pragma mark - RSSFeedParserDelegateReceiver

- (NSString *)xmlIdentifier {
    return @"channel";
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
//#ifdef DEBUG
//    NSLog(@"channel didStartElement: %@", elementName);
//#endif
    _currentElement = elementName;
    _currentElementAttributeDictionary = attributeDict;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
//#ifdef DEBUG
//    NSLog(@"channel didEndElement: %@", elementName);
//#endif
    _currentElement = nil;
    _currentElementAttributeDictionary = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([_currentElement isEqualToString:@"title"]) {
        if (!self.title) {
            self.title = string;
        } else {
            self.title = [self.title stringByAppendingString:string];
        }
    } else if ([_currentElement isEqualToString:@"link"]) {
        self.link = [NSURL URLWithString:string];
    } else if ([_currentElement isEqualToString:@"description"]) {
        self.descriptionTag = string;
    } else if ([_currentElement isEqualToString:@"lastBuildDate"]) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        df.dateFormat = @"E, d MMM yyyy HH:mm:ss Z";
        df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        NSDate *lastBuildDate = [df dateFromString:string];
#ifdef DEBUG
        NSLog(@"lastBuildDateString: %@, lastBuildDate: %@", string, lastBuildDate);
#endif
        self.lastBuildDate = lastBuildDate;
    } else if ([_currentElement isEqualToString:@"language"]) {
        self.language = string;
    } else if ([_currentElement isEqualToString:@"sy:updatePeriod"]) {
        // TODO: Convert to time unit.
        self.syUpdatePeriod = string;
    } else if ([_currentElement isEqualToString:@"sy:updateFrequency"]) {
        // TODO: Convert to time unit.
        self.syUpdateFrequency = string;
    } else if ([_currentElement isEqualToString:@"generator"]) {
        self.generator = string;
    } else if ([_currentElement isEqualToString:@"site"]) {
        XMLElement *element = [[XMLElement alloc] init];
        element.data = _currentElementAttributeDictionary;
        element.value = _currentElement;
        self.site = element;
    } else {
//#ifdef DEBUG
//        NSLog(@"currentElement: %@", _currentElement);
//#endif
    }
}

#pragma mark - NObject

@end
