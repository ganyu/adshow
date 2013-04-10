//
//  AdView.m
//  rrtxt
//
//  Created by gan yu on 13-4-9.
//  Copyright (c) 2013年 shenglang. All rights reserved.
//

#import "AdView.h"
#define kDeviceWidth 320.0f
@implementation MyUIScrollView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.dragging)
    {
        [[self nextResponder] touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.dragging)
    {
        [[self nextResponder] touchesMoved:touches withEvent:event];
    }
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.dragging)
    {
        [[self nextResponder] touchesEnded:touches withEvent:event];
    }
    [super touchesEnded:touches withEvent:event];
}
@end

@implementation AdView
@synthesize delegate=_delegate;
#define ADIMG_INDEX 888
#define ADTITLE_INDEX   889
#define AD_BOTTOM_HEIGHT    12.f

#pragma mark - ----- init frame
- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    
    NSAssert(self, @"Adview:self is nil...");
    
    if (nil != self)
    {
        arr_AdImgs = [[NSMutableArray alloc]init];
        arr_AdTitles = [[NSMutableArray alloc]init];
        // init...
        [self setFrame:frame];
        [self setBackgroundColor:[UIColor clearColor]];
        for (NSDictionary *dic in imageArray) {
            [arr_AdImgs addObject:[dic objectForKey:@"img"]];
            [arr_AdTitles addObject:[dic objectForKey:@"title"]];
        }
        /* ad scroll view */
        sv_Ad = [[MyUIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [sv_Ad setDelegate:self];   // set delegate
        [sv_Ad setScrollEnabled:YES];
        [sv_Ad setPagingEnabled:YES];
        [sv_Ad setShowsHorizontalScrollIndicator:NO];
        [sv_Ad setShowsVerticalScrollIndicator:NO];
        [sv_Ad setAlwaysBounceVertical:NO];
        [sv_Ad setContentSize:CGSizeMake(kDeviceWidth*([arr_AdImgs count]>0?[arr_AdImgs count]:0), sv_Ad.frame.size.height)];
        [self addSubview:sv_Ad];
        
        /* page ctrl */
        pc_AdPage = [[UIPageControl alloc] initWithFrame:CGRectMake(0.f, 0.f, 64.f, 8.f)];
        [pc_AdPage setCenter:CGPointMake(sv_Ad.frame.size.width-64.f/2.f, self.frame.size.height
-24.f/2.f)];
        [pc_AdPage setUserInteractionEnabled:YES];
        [pc_AdPage setAutoresizesSubviews:YES];
        [pc_AdPage setAlpha:1.f];
        [pc_AdPage setCurrentPage:0];
        [pc_AdPage setNumberOfPages:([arr_AdImgs count]>0?[arr_AdImgs count]:0)];
        [self addSubview:pc_AdPage];
        
        /* infomation */
        UIImageView *img_info = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, self.frame.size.height-24.f, sv_Ad.frame.size.width, 24.f)];
        [img_info setBackgroundColor:[UIColor whiteColor]];
        [img_info setAlpha:0.5f];
        [self addSubview:img_info];
        [img_info release];
        
        /* intro */
        lbl_Info = [[UILabel alloc] initWithFrame:CGRectMake(img_info.frame.origin.x+6.f, 0.f, kDeviceWidth-pc_AdPage.frame.size.width, 24.f)];
        [lbl_Info setTag:ADTITLE_INDEX];
        [lbl_Info setBackgroundColor:[UIColor clearColor]];
        [lbl_Info setTextColor:[UIColor blackColor]];
        [lbl_Info setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.f]];
        [lbl_Info setText:arr_AdTitles.count>0 ? [arr_AdTitles objectAtIndex:0]:@""];
        [lbl_Info setTextAlignment:UITextAlignmentLeft];
        [lbl_Info setLineBreakMode:UILineBreakModeWordWrap|UILineBreakModeTailTruncation];
        [img_info addSubview:lbl_Info];
        
        
        /* loading... */
        [self adLoad];
    }
    
    return self;
}

/* ad loading... */
- (void)adLoad
{
    /* set timer */
    [NSTimer scheduledTimerWithTimeInterval:4.5f target:self selector:@selector(changedAdTimer:) userInfo:nil repeats:YES];
    
    [self AddAdImg:arr_AdImgs];
}

#pragma mark - ----- -> 切换广告
static int cur_count = -1;
- (void)changedAdTimer:(NSTimer *)timer
{
    cur_count = pc_AdPage.currentPage;
    ++cur_count;
    pc_AdPage.currentPage = (cur_count%[arr_AdImgs count]);
    
    [UIView animateWithDuration:.7f animations:^{
        [lbl_Info setText:[arr_AdTitles objectAtIndex:pc_AdPage.currentPage]];
        sv_Ad.contentOffset = CGPointMake(pc_AdPage.currentPage*300, 0.f);
    }];
}

#pragma mark - ----- -> 下载广告图片
- (UIImage *)DownloadImgs:(NSString *)str_img
{
    UIImage *down_img = [[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str_img]]] autorelease];
    
    return down_img;
}

#pragma mark - ----- -> 初始化添加广告图片
- (void)AddAdImg:(NSArray*)arr_adimgs
{
    for (int i = 0; i < ([arr_AdImgs count]>0?[arr_AdImgs count]:0); ++i)
    {
        UIImageView *img_Ad = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*i, 0.f, self.frame.size.width, self.frame.size.height)];
        [img_Ad setImage:[self DownloadImgs:[arr_AdImgs objectAtIndex:i]]];//网络图片使用DownloadImgs下载图片
//        [self DownloadImgs:[arr_AdImgs objectAtIndex:i]];//获取本地图片
        [img_Ad setTag:ADIMG_INDEX+i];
        [img_Ad setUserInteractionEnabled:YES];
        [sv_Ad addSubview:img_Ad];
        [img_Ad release];
    }
}


#pragma mark - ----- -> 点击广告
//- (void)clickAd:(int)iTag
//{
//    NSLog(@"click ad%d", iTag);
//}

#pragma mark - ----- -> scrollView opt
enum _jmpFalg { NORMAL = 0, LAST = -1, FIRST = 1 };
BOOL bJmp = NORMAL;
static float maxLoc = 0.f, minLoc = 0.f;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    maxLoc = (maxLoc>scrollView.contentOffset.x)?maxLoc:scrollView.contentOffset.x;
    minLoc = (minLoc<scrollView.contentOffset.x)?minLoc:scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    do
    {
        if (maxLoc > ([arr_AdImgs count]-1)*kDeviceWidth)
        {
            bJmp = FIRST;
            break;
        }
        else if (minLoc < 0*kDeviceWidth)
        {
            bJmp = LAST;
            break;
        }
        else
        {
            bJmp = NORMAL;
            break;
        }
    } while (TRUE);
    
    switch (bJmp)
    {
        case FIRST:
        {
            pc_AdPage.currentPage = 0;
        }
            break;
        case LAST:
        {
            pc_AdPage.currentPage = ([arr_AdImgs count]>0?[arr_AdImgs count]:0);
        }
            break;
        case NORMAL:
        {
            [pc_AdPage setCurrentPage:scrollView.contentOffset.x/kDeviceWidth];
        }
            break;
        default:
            break;
    }
    [UIView animateWithDuration:.7f animations:^{
        [lbl_Info setText:[arr_AdTitles objectAtIndex:pc_AdPage.currentPage]];
        sv_Ad.contentOffset = CGPointMake((pc_AdPage.currentPage%[arr_AdImgs count])*kDeviceWidth, 0.f);
    }];
    maxLoc = minLoc = sv_Ad.contentOffset.x;
}

#pragma mark ----- -> touches opt
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //UITouch *touch = [touches anyObject];
    //CGPoint startPos = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //UITouch *touch = [touches anyObject];
    //CGPoint movePos = [touch locationInView:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:sv_Ad];
    
    if (CGRectContainsPoint(CGRectMake(0, 0, sv_Ad.contentSize.width, sv_Ad.contentSize.height), point))
    {
        //point在rect中的动作
        NSInteger index = fabs(point.x / sv_Ad.frame.size.width);
        [_delegate clickAd:self itag:index];
    }
    
}
#pragma mark ----- -> release memory
- (void)dealloc
{
    
    [super dealloc];
}

@end
