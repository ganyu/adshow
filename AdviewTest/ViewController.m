//
//  ViewController.m
//  AdviewTest
//
//  Created by gan yu on 13-4-10.
//  Copyright (c) 2013年 shenglang. All rights reserved.
//

#import "ViewController.h"
#import "AdwebViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize urlArr;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"广告展示";
    urlArr = [[NSMutableArray alloc]initWithCapacity:3];
    /* -> 添加广告框 */
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]initWithCapacity:3];
    [dic1 setObject:@"1" forKey:@"id"];
    [dic1 setObject:@"http://www.rrtxt.com/images/banner1.png" forKey:@"img"];
    [dic1 setObject:@"百度" forKey:@"title"];
    [dic1 setObject:@"http://www.baidu.com" forKey:@"url"];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]initWithCapacity:3];
    [dic2 setObject:@"2" forKey:@"id"];
    [dic2 setObject:@"http://www.rrtxt.com/images/banner2.png" forKey:@"img"];
    [dic2 setObject:@"谷歌" forKey:@"title"];
    [dic2 setObject:@"http://www.google.com.hk" forKey:@"url"];
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc]initWithCapacity:3];
    [dic3 setObject:@"3" forKey:@"id"];
    [dic3 setObject:@"http://www.rrtxt.com/images/banner3.png" forKey:@"img"];
    [dic3 setObject:@"领我玩" forKey:@"title"];
    [dic3 setObject:@"http://www.05wan.com" forKey:@"url"];
    
    NSMutableArray *imgArr = [[NSMutableArray alloc]initWithObjects:dic1,dic2,dic3,nil];
    for (NSDictionary *dic in imgArr) {
        [urlArr addObject:[dic objectForKey:@"url"]];
    }
    AdView *view_Ad = [[AdView alloc]initWithFrame:CGRectMake(10.0f, 6.0f, 300, 75.0f)imageArray:imgArr];
    view_Ad.delegate = self;
    [self.view addSubview:view_Ad];
    [view_Ad setCenter:CGPointMake(self.view.bounds.size.width/2.0f, 6.0f+view_Ad.frame.size.height/2.0f)];
    [view_Ad release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clickAd:(AdView *)AdView itag:(NSUInteger)itag
{
    AdwebViewController *webView =[[AdwebViewController alloc]initWithNibName:@"AdwebViewController" bundle:nil];
    webView.url = [urlArr objectAtIndex:itag];
    [self.navigationController pushViewController:webView animated:YES];
    
}
@end
