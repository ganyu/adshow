//
//  ViewController.h
//  AdviewTest
//
//  Created by gan yu on 13-4-10.
//  Copyright (c) 2013年 shenglang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdView.h"
@interface ViewController : UIViewController<AdDelegate>
{
    NSMutableArray *urlArr;
}
@property(nonatomic,retain)NSMutableArray *urlArr;
@end
