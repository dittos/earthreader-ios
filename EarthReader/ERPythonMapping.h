//
//  ERPythonMapping.h
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ERPythonObject.h"

@interface ERPythonMapping : NSMutableDictionary

- (id)initWithWrappedObject:(ERPythonObject *)object;
- (id)initWithWrappedObject:(ERPythonObject *)object valueClass:(Class)cls;

- (id)objectForKey:(id)aKey;
- (id)objectForKeyedSubscript:(id)key;
- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey;
- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key;

@end
