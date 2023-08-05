//
//  RSSFeedItemObject.m
//  Newspaperss
//
//  Created by Mark Cornelisse on 15/04/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

#import "RSSFeedItemObject.h"

@interface RSSFeedItemObject ()

@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *currentElementAttributeDictionary;
@property (nonatomic, strong) NSString *currentElement;
@property (nonatomic, strong) NSString *previousElement;

@end

@implementation RSSFeedItemObject

#pragma mark - RSSFeedParserDelegateReceiver

- (NSString *)xmlIdentifier {
    return @"item";
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
//#ifdef DEBUG
//    NSLog(@"item didStartElement: %@", elementName);
//#endif
    _currentElementAttributeDictionary = attributeDict;
    _currentElement = elementName;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
//#ifdef DEBUG
//    NSLog(@"item didEndElement: %@", elementName);
//#endif
    if ([_currentElement isEqualToString:@"content"]) {
        XMLElement *new = [[XMLElement alloc] init];
        new.data = _currentElementAttributeDictionary;
        new.value = nil;
        _content = new;
    }
    _currentElementAttributeDictionary = nil;
    _previousElement = _currentElement;
    _currentElement = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
//#ifdef DEBUG
////    NSLog(@"foundCharacters: %@", string);
//    NSLog(@"foundCharacters for element: %@", _currentElement);
//#endif
    if ([_currentElement isEqualToString:@"title"]) {
        NSLog(@"title: %@", string);
        if ([_previousElement isEqualToString:@"title"]) {
            _title = [_title stringByAppendingString:string];
        } else {
            _title = string;
        }
        
    } else if ([_currentElement isEqualToString:@"link"]) {
        _link = [NSURL URLWithString:string];
    } else if ([_currentElement isEqualToString:@"comments"]) {
        _comments = [NSURL URLWithString:string];
    } else if ([_currentElement isEqualToString:@"creator"]) {
        _dcCreator = string;
    } else if ([_currentElement isEqualToString:@"pubDate"]) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        df.dateFormat = @"E, d MMM yyyy HH:mm:ss Z";
        df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        NSDate *pubDate = [df dateFromString:string];
#ifdef DEBUG
        NSLog(@"pubDateString: %@, pubDate: %@", string, pubDate);
#endif
        _publicationDate = pubDate;
    } else if ([_currentElement isEqualToString:@"category"]) {
        _category = string;
    } else if ([_currentElement isEqualToString:@"guid"]) {
        XMLElement *new = [[XMLElement alloc] init];
        new.data = _currentElementAttributeDictionary;
        new.value = [NSURL URLWithString:string];
        _guid = new;
    } else if ([_currentElement isEqualToString:@"description"]) {
        _descriptionTag = string;
    } else if ([_currentElement isEqualToString:@"encoded"]) {
        _encoded = string;
    } else if ([_currentElement isEqualToString:@"commentRss"]) {
        _commentsRss = [NSURL URLWithString:string];
    } else if ([_currentElement isEqualToString:@"comments"]) {
        _slashComments = string;
    } else if ([_currentElement isEqualToString:@"post-id"]) {
        _postId = string;
    }
}

#pragma mark - NSObject

- (NSComparisonResult)compare:(RSSFeedItemObject *)other {
    return [self.publicationDate compare:other.publicationDate];
}

@end
