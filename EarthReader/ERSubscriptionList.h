//
//  ERSubscriptionList.h
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERPythonObject.h"
#import "ERFeed.h"

@interface ERSubscriptionList : ERPythonObject

@property (readonly) NSArray *children;

- (ERPythonObject *)subscribe:(ERFeed *)feed;

@end
