//
//  ERLocalAPIManager.m
//  EarthReader
//
//  Created by 김태호 on 2014. 1. 2..
//  Copyright (c) 2014년 Earth Reader. All rights reserved.
//

#import "ERLocalAPIManager.h"

@implementation ERLocalAPIManager

- (id)initWithLocalPort:(NSUInteger)port {
    if (self = [super initWithRootURL:nil]) {
        self.port = port;
    }
    return self;
}

- (void)setPort:(NSUInteger)port {
    self.rootURL = [@"http://localhost:" stringByAppendingFormat:@"%u", port];
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    if ([request.URL.host isEqualToString:@"localhost"]) {
        NSMutableURLRequest *req = [request mutableCopy];
        req.URL = [NSURL URLWithString:req.URL.path relativeToURL:[NSURL URLWithString:self.rootURL]];
        request = req;
    }
    return [super HTTPRequestOperationWithRequest:request success:success failure:failure];
}

@end
