//
//  ERFeedViewController.h
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ERFeed.h"
#import "ERSubscription.h"

@interface ERFeedViewController : UITableViewController

- (id)initWithObject:(NSDictionary *)subscription;

@end
