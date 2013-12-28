//
//  ERSession.h
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ERPythonObject.h"

@interface ERSession : ERPythonObject

+ (ERSession *)defaultSession;
+ (NSString *)defaultSessionID;

- (id)initWithSessionID:(NSString *)sessionId;

@property (readonly, strong) NSString *sessionId;

@end
