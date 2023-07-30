//
//  XMLElement.h
//  Newspaperss
//
//  Created by Mark Cornelisse on 14/04/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface XMLElement : NSObject

@property (nonatomic, strong, nullable) NSDictionary *data;
@property (nonatomic, strong, nullable) id value;

@end

NS_ASSUME_NONNULL_END
