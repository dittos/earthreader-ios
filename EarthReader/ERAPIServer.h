//
//  ERAPIServer.h
//  EarthReader
//
//  Created by 김태호 on 2014. 1. 1..
//  Copyright (c) 2014년 Earth Reader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERAPIServer : NSObject

+ (ERAPIServer *)sharedServer;

- (id)init;
- (void)start;
- (void)stop;

@property (readonly) NSString *repositoryPath;
@property (readonly) NSUInteger port;

@end
