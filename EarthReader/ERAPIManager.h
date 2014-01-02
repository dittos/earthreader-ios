//
//  ERAPIManager.h
//  EarthReader
//
//  Created by 김태호 on 2014. 1. 1..
//  Copyright (c) 2014년 Earth Reader. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface ERAPIManager : AFHTTPRequestOperationManager

+ (ERAPIManager *)sharedManager;
+ (void)setSharedManager:(ERAPIManager *)manager;

- (id)initWithRootURL:(NSString *)rootURL;

@property (copy, nonatomic) NSString *rootURL;

@end
