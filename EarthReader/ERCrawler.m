//
//  ERCrawler.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 31..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERCrawler.h"

@interface ERCrawler () {
    ERStage *_stage;
}
@end

@implementation ERCrawler

+ (ERCrawler *)sharedCrawler {
    static ERCrawler *crawler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        crawler = [[ERCrawler alloc] initWithStage:[ERStage currentStage]];
    });
    return crawler;
}

- (id)initWithStage:(ERStage *)stage {
    if (self = [super init]) {
        _stage = stage;
    }
    return self;
}

- (void)subscribe:(NSString *)url
           inList:(ERSubscriptionList *)list
completionHandler:(void (^)(ERFeed *))completionBlock {
    [ERFeed fetchFromURL:url completionHandler:^(ERFeed *feed) {
        if (feed) {
            ERSubscription *sub = [list subscribe:feed];
            _stage.subscriptions = list;
            _stage.feeds[sub.feedID] = feed;
            [_stage commit];
        }
        completionBlock(feed);
    }];
}

- (void)refresh:(ERSubscription *)subscription completionHandler:(void (^)(ERSubscription *, ERFeed *))completionBlock {
    [ERFeed fetchFromURL:subscription.feedURI
       completionHandler:^(ERFeed *feed) {
           if (feed) {
               // XXX: what if feed uri changes?
               _stage.feeds[subscription.feedID] = feed;
               [_stage commit];
           }
           completionBlock(subscription, feed);
       }];
}

@end
