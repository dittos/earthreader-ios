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
    Class _elemClass;
}
@end

@implementation ERPythonSequence

- (id)initWithWrappedObject:(ERPythonObject *)object {
    return [self initWithWrappedObject:object elementClass:[ERPythonObject class]];
}

- (id)initWithWrappedObject:(ERPythonObject *)object elementClass:(Class)cls {
    if (self = [super init]) {
        _backingObject = object;
        _elemClass = cls;
    }
    return self;
}

- (NSUInteger)count {
    return (NSUInteger)PySequence_Size(_backingObject.handle);
}

- (id)objectAtIndex:(NSUInteger)index {
    return [[_elemClass alloc] initWithWrappedObject:_backingObject[index]];
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self objectAtIndex:idx];
}

@end
