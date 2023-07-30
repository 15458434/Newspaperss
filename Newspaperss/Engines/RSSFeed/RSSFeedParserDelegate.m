//
//  RSSFeedParserDelegate.m
//  Newspaperss
//
//  Created by Mark Cornelisse on 14/04/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

#import "RSSFeedParserDelegate.h"
#import "RSSFeedParserDelegateReceiver.h"
#import "RSSFeedItemObject.h"
#import "RSSFeedImageObject.h"

@interface RSSFeedParserDelegate ()

@property (nonatomic, strong) NSMutableArray<id<RSSFeedParserDelegateReceiver>> *currentElementStack;

@end

@implementation RSSFeedParserDelegate

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
//#ifdef DEBUG
//    NSLog(@"didStart elementName: %@ with attributes: %@", elementName, attributeDict);
//#endif
    if (_currentElementStack.count > 0) {
        id<RSSFeedParserDelegateReceiver> currentElement = _currentElementStack.lastObject;
        NSString *currentXmlIdentifier = currentElement.xmlIdentifier;
        if ([currentXmlIdentifier isEqualToString:@"channel"]) {
            if ([elementName isEqualToString:@"item"]) {
                RSSFeedItemObject *new = [[RSSFeedItemObject alloc] init];
                [_currentElementStack addObject:new];
//#ifdef DEBUG
//                NSLog(@"didStartElement item");
//#endif
            } else if ([elementName isEqualToString:@"image"]) {
                RSSFeedImageObject *new = [[RSSFeedImageObject alloc] init];
                [_currentElementStack addObject:new];
            } else {
                [currentElement parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
            }
            return;
        } else if ([currentXmlIdentifier isEqualToString:@"item"]) {
            [currentElement parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
        } else if ([currentXmlIdentifier isEqualToString:@"image"]) {
            [currentElement parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
        }
    } else {
        if ([elementName isEqualToString:@"channel"]) {
            RSSFeedChannelObject *new = [[RSSFeedChannelObject alloc] init];
            [_currentElementStack addObject:new];
//#ifdef DEBUG
//            NSLog(@"didStartElement channel");
//#endif
            return;
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
//#ifdef DEBUG
//    NSLog(@"didEnd elementName: %@", elementName);
//#endif
    if (_currentElementStack.count > 0) {
        id<RSSFeedParserDelegateReceiver> currentElement = _currentElementStack.lastObject;
        NSString *currentXmlIdentifier = currentElement.xmlIdentifier;
        if ([currentXmlIdentifier isEqualToString:@"channel"]) {
            if ([elementName isEqualToString:@"channel"]) {
                _channelData = (RSSFeedChannelObject *)_currentElementStack.lastObject;
                [_currentElementStack removeLastObject];
//#ifdef DEBUG
//                NSLog(@"didEndElement: channel");
//#endif
            } else {
                [currentElement parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
            }
            return;
        } else if ([currentXmlIdentifier isEqualToString:@"item"]) {
            if ([elementName isEqualToString:@"item"]) {
                RSSFeedItemObject *completedItem = (RSSFeedItemObject *)_currentElementStack.lastObject;
                [_currentElementStack removeLastObject];
                RSSFeedChannelObject *channelObject = (RSSFeedChannelObject *)_currentElementStack.lastObject;
                [channelObject addItem:completedItem];
//#ifdef DEBUG
//                NSLog(@"didEndElement: item");
//#endif
            } else {
                [currentElement parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
            }
        } else if ([currentXmlIdentifier isEqualToString:@"image"]) {
            if ([elementName isEqualToString:@"image"]) {
                RSSFeedImageObject *completedImage = (RSSFeedImageObject *)_currentElementStack.lastObject;
                [_currentElementStack removeLastObject];
                RSSFeedChannelObject *channelObject = (RSSFeedChannelObject *)_currentElementStack.lastObject;
                channelObject.image = completedImage;
            } else {
                [currentElement parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
            }
        } else {
//#ifdef DEBUG
//            NSLog(@"currentElement: %@", elementName);
//#endif
        }
    } 
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
//#ifdef DEBUG
//    NSLog(@"foundCharacters: %@", string);
//#endif
    NSString *xmlIdentifier = _currentElementStack.lastObject.xmlIdentifier;
    if ([xmlIdentifier isEqualToString:@"channel"]) {
        [_currentElementStack.lastObject parser:parser foundCharacters:string];
    } else if ([xmlIdentifier isEqualToString:@"item"]) {
        [_currentElementStack.lastObject parser:parser foundCharacters:string];
    } else if ([xmlIdentifier isEqualToString:@"image"]) {
        [_currentElementStack.lastObject parser:parser foundCharacters:string];
    }
}

#pragma mark - NSObject

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentElementStack = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
