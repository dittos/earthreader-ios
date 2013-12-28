//
//  ERStage.h
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERPythonObject.h"
#import "ERPythonMapping.h"
#import "ERSession.h"
#import "ERRepo.h"
#import "ERSubscriptionList.h"

@interface ERStage : ERPythonObject

+ (ERStage *)currentStage;
+ (void)setCurrentStage:(ERStage *)stage;

- (id)initWithSession:(ERSession *)session usingRepo:(ERRepo *)repo;
- (void)commit;

@property (readwrite) ERSubscriptionList *subscriptions;
@property (readonly) ERPythonMapping *feeds;

@end
