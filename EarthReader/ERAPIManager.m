//
//  ERAPIManager.m
//  EarthReader
//
//  Created by 김태호 on 2014. 1. 1..
//  Copyright (c) 2014년 Earth Reader. All rights reserved.
//

#import "ERAPIManager.h"

static ERAPIManager *_sharedManager = nil;

@implementation ERAPIManager

+ (ERAPIManager *)sharedManager {
    // TODO: synchronization?
    return _sharedManager;
}

+ (void)setSharedManager:(ERAPIManager *)manager {
    _sharedManager = manager;
}

- (id)initWithRootURL:(NSString *)rootURL {
    if (self = [super initWithBaseURL:nil]) {
        _rootURL = rootURL;
    }
    return self;
}

@end
