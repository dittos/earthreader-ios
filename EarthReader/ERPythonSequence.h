//
//  ERSubscriptionList.h
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ERPythonObject.h"

@interface ERPythonSequence : NSArray

- (id)initWithWrappedObject:(ERPythonObject *)object;

- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

@end
