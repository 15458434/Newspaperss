//
//  RSSFeedImageObject.m
//  Newspaperss
//
//  Created by Mark Cornelisse on 16/04/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

#import "RSSFeedImageObject.h"

@interface RSSFeedImageObject ()

@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *currentElementAttributeDictionary;
@property (nonatomic, strong) NSString *currentElement;

@end

@implementation RSSFeedImageObject

#pragma mark - RSSFeedParserDelegateReceiver

- (NSString *)xmlIdentifier {
    return @"image";
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    _currentElementAttributeDictionary = attributeDict;
    _currentElement = elementName;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    _currentElementAttributeDictionary = nil;
    _currentElement = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([_currentElement isEqualToString:@"url"]) {
        _url = [NSURL URLWithString:string];
    } else if ([_currentElement isEqualToString:@"title"]) {
        if (!_title) {
            _title = string;
        } else {
            _title = [_title stringByAppendingString:string];
        }
    } else if ([_currentElement isEqualToString:@"link"]) {
        _link = [NSURL URLWithString:string];
    } else if ([_currentElement isEqualToString:@"width"]) {
        _width = @(string.doubleValue);
    } else if ([_currentElement isEqualToString:@"height"]) {
        _height = @(string.doubleValue);
    }
}

@end
