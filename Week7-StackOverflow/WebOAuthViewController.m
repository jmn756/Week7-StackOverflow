//
//  WebOAuthViewController.m
//  Week7-StackOverflow
//
//  Created by Joey Nessif on 9/15/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "WebOAuthViewController.h"
#import <WebKit/WebKit.h>
#import "AppDelegate.h"

@interface WebOAuthViewController () <WKNavigationDelegate>

@end

@implementation WebOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
  [self.view addSubview:webView];
  webView.navigationDelegate = self;
  
  NSString *baseURL = @"https://stackexchange.com/oauth/dialog";
  NSString *clientID = @"5578";
  NSString *redirectURI = @"https://stackexchange.com/oauth/login_success";
  NSString *finalURL = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseURL,clientID,redirectURI];
  [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:finalURL]]];
  
  // Do any additional setup after loading the view.
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
  //  NSLog(@"%@",navigationAction.request.URL.description);
  
  NSLog(@"%@",navigationAction.request.URL.path);
  
  if ([navigationAction.request.URL.path isEqualToString:@"/oauth/login_success"]) {
    NSString *fragmentString = navigationAction.request.URL.fragment;
    NSArray *components = [fragmentString componentsSeparatedByString:@"&"];
    NSString *fullTokenParameter = components.firstObject;
    NSString *token = [fullTokenParameter componentsSeparatedByString:@"="].lastObject;
    NSLog(@"%@",token);
    [self saveTokenToUserDefaults:token];
    [self dismissViewControllerAnimated:true completion:nil];
    
  }
  decisionHandler(WKNavigationActionPolicyAllow);
  
}


-(void)saveTokenToUserDefaults: (NSString *)token{
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  appDelegate.userDefaults = [NSUserDefaults standardUserDefaults];
  
  [appDelegate.userDefaults setObject:token forKey:@"tokenString"];
  
  
}
@end
