//
//  ERFeed.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERFeed.h"

@implementation ERFeed

+ (void)fetchFromURL:(NSString *)url
   completionHandler:(void (^)(ERFeed *))completionBlock {
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               completionBlock([self parseData:data url:url contentType:response.MIMEType]);
                           }];
}

+ (ERFeed *)parseData:(NSData *)data url:(NSString *)url contentType:(NSString *)contentType {
    PyObject *body = PyString_FromStringAndSize(data.bytes, data.length);
    ERPythonObject *parseFeed = [ERPythonObject moduleWithName:"helpers"][@"parse_feed"];
    ERPythonObject *t = [parseFeed callWithArgs:"(Oss)", body, url.UTF8String, contentType.UTF8String];
    Py_XDECREF(body);
    if (t)
        return [[ERFeed alloc] initWithWrappedObject:t[0]];
    return nil;
}

@end
