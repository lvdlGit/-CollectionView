//
//  LoopCollectionView.h
//  LoopScrollView
//
//  Created by lvdl on 15/11/4.
//  Copyright © 2015年 www.palcw.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoopCollectionView;

@protocol LoopCollectionViewDelegate <NSObject>

@optional

- (void)loopCollectionView:(LoopCollectionView *)collectionView didSelectItem:(NSInteger)index;
- (void)loopCollectionView:(LoopCollectionView *)collectionView currentItem:(NSInteger)index;

@end

@interface LoopCollectionView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) id<LoopCollectionViewDelegate> loopDelegate;

// 如果数据数组大于1，则在首尾分别添加尾数据和头数据的 可变数组
@property (nonatomic, strong) NSMutableArray *sourceData;

/*
 * 根据数据创建循环滚动视图
 */
- (id)initWithFrame:(CGRect)frame withData:(NSArray *)dataArr;

/*
 * 重写timeInterval的set方法，启动自动滚动视图 (默认3秒)
 */
- (void)setTimeInterval:(CGFloat)timeInterval;

/*
 * 重写isAuto的set方法，启动自动滚动视图
 */
- (void)setIsAuto:(BOOL)isAuto;
/*
 * 设置 显示 pageControl
 */
- (void)setShowPageControl:(BOOL)showPageControl;

/*
 * 设置pageControl的frame
 */
- (void)setPageControlFrame:(CGRect)frame;

/*
 * 设置pageControl的选中的颜色
 */
- (void)setPageControlCurrentPageIndicatorTintColor:(UIColor *)color;

/*
 * 设置pageControl的未选中的颜色
 */
- (void)setPageControlPageIndicatorTintColor:(UIColor *)color;

@end
