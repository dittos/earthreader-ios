//
//  ERSubscription.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 31..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERSubscription.h"

@implementation ERSubscription

- (NSString *)feedID {
    return [self[@"feed_id"] stringValue];
}

- (NSString *)feedURI {
    return [self[@"feed_uri"] stringValue];
}

@end
