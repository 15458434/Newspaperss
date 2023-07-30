//
//  RSSFeedParserDelegateReceiver.h
//  Newspaperss
//
//  Created by Mark Cornelisse on 15/04/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

@protocol RSSFeedParserDelegateReceiver
    
@property (nonatomic, strong, readonly) NSString *xmlIdentifier;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;

@end
