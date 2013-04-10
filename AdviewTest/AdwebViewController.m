//
//  AdwebViewController.m
//  rrtxt
//
//  Created by gan yu on 13-4-9.
//  Copyright (c) 2013年 shenglang. All rights reserved.
//

#import "AdwebViewController.h"
#import "ViewController.h"
@interface AdwebViewController ()

@end

@implementation AdwebViewController
@synthesize webView,activityIndicator,url,btnBack;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320, 480)];
    webView.scalesPageToFit =YES;
    [webView setDelegate:self];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
