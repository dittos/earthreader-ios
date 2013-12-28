//
//  ERFeed.h
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERPythonObject.h"

@interface ERFeed : ERPythonObject

+ (void)fetchFromURL:(NSString *)url
   completionHandler:(void(^)(ERFeed *))completionBlock;

@property (readonly) NSArray *entries;

@end
