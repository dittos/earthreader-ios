//
//  ERCrawler.h
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 31..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ERStage.h"

@interface ERCrawler : NSObject

+ (ERCrawler *)sharedCrawler;

- (id)initWithStage:(ERStage *)stage;

- (void)subscribe:(NSString *)url
           inList:(ERSubscriptionList *)list
completionHandler:(void(^)(ERFeed *))completionBlock;

- (void)refresh:(ERSubscription *)subscription completionHandler:(void(^)(ERSubscription *, ERFeed *))completionBlock;

@end
