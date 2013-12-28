//
//  ERStage.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERStage.h"

@implementation ERStage

- (id)initWithSession:(ERSession *)session usingRepo:(ERRepo *)repo {
    ERPythonObject *cls = [ERPythonObject moduleWithName:"libearth.stage"][@"Stage"];
    self = [super initWithWrappedObject:[cls callWithArgs:"OO", session.handle, repo.handle]];
    return self;
}

- (void)open {
    [self[@"__enter__"] callWithArgs:"()"];
}

- (void)close {
    [self[@"__exit__"] callWithArgs:"()"]; // TODO: error handling
}

- (ERSubscriptionList *)subscriptions {
    return [[ERSubscriptionList alloc] initWithWrappedObject:self[@"subscriptions"]];
}

@end
