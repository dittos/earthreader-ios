//
//  ERSubscriptionList.h
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERPythonObject.h"
#import "ERFeed.h"
#import "ERSubscription.h"

@interface ERSubscriptionList : ERPythonObject

@property (readonly) NSArray *children;

- (ERSubscription *)subscribe:(ERFeed *)feed;

@end
