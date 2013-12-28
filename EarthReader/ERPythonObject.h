//
//  ERPythonObject.h
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERPythonObject : NSObject

+ (ERPythonObject *)moduleWithName:(const char *)name;

- (id)initWithHandle:(PyObject *)handle;
- (id)initWithWrappedObject:(ERPythonObject *)obj;

- (ERPythonObject *)callWithArgs:(const char *)spec, ...;
- (id)objectForKeyedSubscript:(id <NSCopying>)key;
- (void)print;

- (NSString *)stringValue;

@property (readonly) PyObject *handle;

@end
