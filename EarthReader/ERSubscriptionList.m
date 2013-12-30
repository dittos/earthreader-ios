//
//  ERSubscriptionList.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERSubscriptionList.h"
#import "ERPythonSequence.h"
#import "ERSubscription.h"

@implementation ERSubscriptionList

- (NSArray *)children {
    // TODO: handle categories
    return [[ERPythonSequence alloc] initWithWrappedObject:self[@"children"] elementClass:[ERSubscription class]];
}

- (ERSubscription *)subscribe:(ERFeed *)feed {
    return [[ERSubscription alloc] initWithWrappedObject:[self[@"subscribe"] callWithArgs:"(O)", feed.handle]];
}

@end
