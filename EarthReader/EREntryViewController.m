//
//  EREntryViewController.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 30..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "EREntryViewController.h"

@interface EREntryViewController () {
    UIWebView *_webView;
    NSDictionary *_entry;
}
@end

@implementation EREntryViewController

- (id)initWithObject:(NSDictionary *)entry
{
    if (self = [super init]) {
        _entry = entry;
    }
    return self;
}

- (void)loadView
{
    _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.view = _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData {
    [[ERAPIManager sharedManager] GET:_entry[@"entry_url"]
                           parameters:nil
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  [self parseResponse:responseObject];
                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  
                              }];
}

- (void)parseResponse:(NSDictionary *)response {
    [_webView loadHTMLString:response[@"content"] baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
