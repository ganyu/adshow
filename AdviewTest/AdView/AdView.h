//
//  AdView.h
//  rrtxt
//
//  Created by gan yu on 13-4-9.
//  Copyright (c) 2013年 shenglang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdView;

@protocol AdDelegate <NSObject>
- (void)clickAd:(AdView *)AdView itag:(NSUInteger)itag;
@end

@interface MyUIScrollView : UIScrollView
@end

@interface AdView : UIView<UIScrollViewDelegate, UIPageViewControllerDelegate>
{
    MyUIScrollView  *sv_Ad; // 广告
    UIPageControl   *pc_AdPage; // 广告页码
    UILabel *lbl_Info;  // 广告标题
    NSMutableArray *arr_AdImgs;    // 广告图片
    NSMutableArray *arr_AdTitles;   // 广告标题
}
- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;

@property (nonatomic, assign) id<AdDelegate> delegate;
- (void)adLoad;

@end