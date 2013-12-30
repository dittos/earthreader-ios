//
//  ERStage.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERStage.h"

static ERStage *_currentStage = nil;

@implementation ERStage

+ (ERStage *)currentStage {
    return _currentStage;
}

+ (void)setCurrentStage:(ERStage *)stage {
    _currentStage = stage;
}

- (id)initWithSession:(ERSession *)session usingRepo:(ERRepo *)repo {
    ERPythonObject *cls = [ERPythonObject moduleWithName:"libearth.stage"][@"Stage"];
    self = [super initWithWrappedObject:[cls callWithArgs:"OO", session.handle, repo.handle]];
    [self open];
    return self;
}

- (void)open {
    [self[@"__enter__"] callWithArgs:"()"];
}

- (void)close {
    [self[@"__exit__"] callWithArgs:"(sss)", 0, 0, 0]; // TODO: error handling
}

- (void)commit {
    [self close];
    [self open];
}

- (ERSubscriptionList *)subscriptions {
    ERPythonObject *subslist = self[@"subscriptions"];
    if (subslist.handle == Py_None)
        subslist = [[ERPythonObject moduleWithName:"libearth.subscribe"][@"SubscriptionList"] callWithArgs:"()"];
    return [[ERSubscriptionList alloc] initWithWrappedObject:subslist];
}

- (void)setSubscriptions:(ERSubscriptionList *)subscriptions {
    self[@"subscriptions"] = subscriptions;
}

- (ERPythonMapping *)feeds {
    return [[ERPythonMapping alloc] initWithWrappedObject:self[@"feeds"] valueClass:[ERFeed class]];
}

@end
