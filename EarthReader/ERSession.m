//
//  ERSession.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERSession.h"

NSString * const ERSessionUserDefaultsSessionIDKey = @"session-id";

@implementation ERSession

+ (ERSession *)defaultSession {
    static ERSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[ERSession alloc] initWithSessionID:[self defaultSessionID]];
    });
    return session;
}

+ (NSString *)defaultSessionID {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sessionId = [defaults stringForKey:ERSessionUserDefaultsSessionIDKey];
    if (!sessionId) {
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        if (uuid) {
            sessionId = (__bridge NSString *)CFUUIDCreateString(NULL, uuid);
            CFRelease(uuid);
        }
        [defaults setObject:sessionId forKey:ERSessionUserDefaultsSessionIDKey];
        [defaults synchronize];
    }
    return sessionId;
}

- (id)initWithSessionID:(NSString *)sessionId {
    ERPythonObject *cls = [ERPythonObject moduleWithName:"libearth.session"][@"Session"];
    self = [super initWithWrappedObject:[cls callWithArgs:"(s)", [sessionId UTF8String]]];
    if (self) {
        _sessionId = sessionId;
    }
    return self;
}

@end
