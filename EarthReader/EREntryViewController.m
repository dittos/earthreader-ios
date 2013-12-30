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
    ERPythonObject *_entry;
}
@end

@implementation EREntryViewController

- (id)initWithObject:(ERPythonObject *)entry
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
    
    ERPythonObject *content = _entry[@"content"];
    if (content.handle == Py_None)
        content = _entry[@"summary"];
    
    if (content.handle == Py_None) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    NSString *contentHTML = [content[@"sanitized_html"] stringValue];
    
	[_webView loadHTMLString:contentHTML baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
