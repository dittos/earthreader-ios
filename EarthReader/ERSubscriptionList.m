//
//  ERSubscriptionList.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERSubscriptionList.h"
#import "ERPythonSequence.h"

@implementation ERSubscriptionList

- (NSArray *)children {
    return [[ERPythonSequence alloc] initWithWrappedObject:self[@"children"]];
}

- (ERPythonObject *)subscribe:(ERFeed *)feed {
    return [self[@"subscribe"] callWithArgs:"(O)", feed.handle];
}

@end
