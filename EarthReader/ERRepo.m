//
//  ERRepo.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERRepo.h"

@implementation ERRepo

- (id)initWithPath:(NSString *)path {
    ERPythonObject *fn = [ERPythonObject moduleWithName:"libearth.repository"][@"from_url"];
    self = [super initWithWrappedObject:[fn callWithArgs:"(s)", [path UTF8String]]];
    if (self) {
    }
    return self;
}

@end
