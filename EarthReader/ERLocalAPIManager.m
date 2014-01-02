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
    _port = port;
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    if ([request.URL.host isEqualToString:@"localhost"] &&
        [request.URL.port unsignedIntegerValue] != _port) {
        NSMutableURLRequest *req = [request mutableCopy];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"localhost:[0-9]+" options:0 error:nil];
        NSString *url = req.URL.absoluteString;
        url = [regex stringByReplacingMatchesInString:url options:0 range:NSMakeRange(0, url.length) withTemplate:[@"localhost:" stringByAppendingFormat:@"%u", _port]];
        req.URL = [NSURL URLWithString:url];
        request = req;
    }
    return [super HTTPRequestOperationWithRequest:request success:success failure:failure];
}

@end
