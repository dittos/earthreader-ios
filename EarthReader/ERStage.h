//
//  ERStage.h
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERPythonObject.h"
#import "ERSession.h"
#import "ERRepo.h"
#import "ERSubscriptionList.h"

@interface ERStage : ERPythonObject

- (id)initWithSession:(ERSession *)session usingRepo:(ERRepo *)repo;

- (void)open;
- (void)close;

@property (readonly) ERSubscriptionList *subscriptions;

@end
