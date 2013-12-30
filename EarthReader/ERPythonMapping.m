//
//  ERPythonMapping.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERPythonMapping.h"

@interface ERPythonMapping () {
    __strong ERPythonObject *_backingObject;
    Class _valueClass;
}
@end

@implementation ERPythonMapping

- (id)initWithWrappedObject:(ERPythonObject *)object {
    return [self initWithWrappedObject:object valueClass:[ERPythonObject class]];
}

- (id)initWithWrappedObject:(ERPythonObject *)object valueClass:(__unsafe_unretained Class)cls {
    if (self = [super init]) {
        _backingObject = object;
        _valueClass = cls;
    }
    return self;
}

- (id)objectForKey:(id)aKey {
    PyObject *value = PyMapping_GetItemString(_backingObject.handle, ((NSString *) aKey).UTF8String);
    ERPythonObject *obj = [[_valueClass alloc] initWithHandle:value];
    Py_XDECREF(value);
    return obj;
}

- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    PyMapping_SetItemString(_backingObject.handle, ((NSString *) aKey).UTF8String, [anObject handle]);
}

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    [self setObject:obj forKey:key];
}

@end
