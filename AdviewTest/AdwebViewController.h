//
//  AdwebViewController.h
//  rrtxt
//
//  Created by gan yu on 13-4-9.
//  Copyright (c) 2013年 shenglang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdwebViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
    NSString *url;
    UIBarButtonItem *btnBack;//返回按钮
}
@property(nonatomic,assign)UIWebView *webView;
@property(nonatomic,assign)UIActivityIndicatorView *activityIndicator;
@property(nonatomic,assign)NSString *url;
@property(nonatomic,retain)UIBarButtonItem *btnBack;
@end
