//
//  ERSubscriptionList.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERPythonSequence.h"

@interface ERPythonSequence () {
    __strong ERPythonObject *_backingObject;
}
@end

@implementation ERPythonSequence

- (id)initWithWrappedObject:(ERPythonObject *)object {
    if (self = [super init]) {
        _backingObject = object;
    }
    return self;
}

- (NSUInteger)count {
    return (NSUInteger)PySequence_Size(_backingObject.handle);
}

- (id)objectAtIndex:(NSUInteger)index {
    return _backingObject[index];
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self objectAtIndex:idx];
}

@end
