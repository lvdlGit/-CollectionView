//
//  ViewController.m
//  LoopScrollView
//
//  Created by lvdl on 15/11/4.
//  Copyright © 2015年 www.palcw.com. All rights reserved.
//

#import "ViewController.h"
#import "LoopCollectionView.h"
#import "LabelLoopView.h"

@interface ViewController () <LoopCollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat height = self.view.bounds.size.height * 0.5;
    CGFloat width = self.view.bounds.size.width;
    
    NSArray *imageArr = @[@"banner1_01.png", @"banner1_02.png"];
    if (imageArr && [imageArr count] > 0) {
        
        CGRect loopFrame = CGRectMake(0, 0, width, height - 50);
        LoopCollectionView *imageLoop = [[LoopCollectionView alloc] initWithFrame:loopFrame withData:imageArr];
        [self.view addSubview:imageLoop];
        
        imageLoop.loopDelegate = self;
        
        // 自动 循环 滚动
        [imageLoop setIsAuto:YES];
    }
    
    NSArray *arrData = @[@"label 0",@"label 1", @"label 2", @"label 3", @"label 4", @"label 5", @"label 6", @"label 7", @"label 8", @"label 9"];

    if (imageArr && [imageArr count] > 0) {
        CGRect imageFrame = CGRectMake(0, height - 30, width, height);
        
        LabelLoopView *loopView = [[LabelLoopView alloc] initWithFrame:imageFrame withData:arrData];
        [self.view addSubview:loopView];
        
        loopView.loopDelegate = self;
        
        // 自动 循环 滚动
        [loopView setIsAuto:YES];
        
        
//        // 隐藏 分页 控制器
//        [loopView setShowPageControl:NO];
    }
}

#pragma mark - LoopCollectionViewDelegate
- (void)loopCollectionView:(LoopCollectionView *)collectionView didSelectItem:(NSInteger)index
{
    NSString *msg ;
    if ([collectionView isKindOfClass:[LabelLoopView class]]) {
        
        msg = [NSString stringWithFormat:@"点击了第 %ld 个Label", (long)index];
    }
    else if ([collectionView isKindOfClass:[LoopCollectionView class]]) {
        
        msg = [NSString stringWithFormat:@"点击了第 %ld 个banner图", (long)index];
    }
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)loopCollectionView:(LoopCollectionView *)collectionView currentItem:(NSInteger)index
{
    
    
}

// 白色 状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
