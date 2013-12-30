//
//  ERSubscription.h
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 31..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERPythonObject.h"

@interface ERSubscription : ERPythonObject

@property (readonly) NSString *feedID;
@property (readonly) NSString *feedURI;

@end
