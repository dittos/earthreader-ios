//
//  ERLocalAPIManager.h
//  EarthReader
//
//  Created by 김태호 on 2014. 1. 2..
//  Copyright (c) 2014년 Earth Reader. All rights reserved.
//

#import "ERAPIManager.h"

@interface ERLocalAPIManager : ERAPIManager

- (id)initWithLocalPort:(NSUInteger)port;

@property (assign, nonatomic) NSUInteger port;

@end
