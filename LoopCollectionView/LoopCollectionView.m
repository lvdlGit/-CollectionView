//
//  LoopCollectionView.m
//  LoopScrollView
//
//  Created by lvdl on 15/11/4.
//  Copyright © 2015年 www.palcw.com. All rights reserved.
//

#import "LoopCollectionView.h"
#import "LoopCollectionCell.h"

#define            ITEM_WIDTH                  self.bounds.size.width
#define            Image_View_Tag              600
#define            Time_Interval_Default       3.0f

#define  RGBA(r, g, b, a)   [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]

static NSString *kIdentifier = @"LoopCollectionCell";

@interface LoopCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

// pageControl
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) BOOL showPageControl;

// 是否自动滚动
@property (nonatomic, assign) BOOL isAuto;

// 自动滚动时间间隔
@property (nonatomic, assign) CGFloat timeInterval;

@property (nonatomic, strong) NSArray *data;

@end

@implementation LoopCollectionView

/**
 重写timeInterval的set方法，启动自动滚动视图
 */

- (void)setTimeInterval:(CGFloat)timeInterval
{
    _timeInterval = timeInterval;
    [self performSelector:@selector(autoScroll) withObject:nil afterDelay:self.timeInterval];
}
/**
 重写isAuto的set方法，启动自动滚动视图
 */
- (void)setIsAuto:(BOOL)isAuto
{
    _isAuto = isAuto;
    if (_timeInterval == 0) {
        _timeInterval = Time_Interval_Default;
    }
    [self performSelector:@selector(autoScroll) withObject:nil afterDelay:self.timeInterval];
}

// 设置 显示 pageControl
- (void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    
    self.pageControl.hidden = !_showPageControl;
}

// 设置pageControl的frame
- (void)setPageControlFrame:(CGRect)frame
{
    self.pageControl.frame = frame;
}

// 设置pageControl的未选中的颜色
- (void)setPageControlPageIndicatorTintColor:(UIColor *)color
{
    self.pageControl.pageIndicatorTintColor = color;
}

// 设置pageControl的选中的颜色
- (void)setPageControlCurrentPageIndicatorTintColor:(UIColor *)color
{
    self.pageControl.currentPageIndicatorTintColor = color;
}

- (id)initWithFrame:(CGRect)frame withData:(NSArray *)dataArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _data = dataArr;
        
        [self analysisData];
        
        [self createView];
    }
    return self;
}

- (void)analysisData
{
    _sourceData = [NSMutableArray arrayWithArray:_data];
    
    // 如果添加的图片数组大于1，则在首尾分别添加尾照片和头照片
    if (_data.count > 1) {
    
        [_sourceData addObject:[_sourceData firstObject]];
        [_sourceData insertObject:_data[_sourceData.count-2] atIndex:0];
    }
}

- (void)createView
{
    //--设置热门的CollectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    flowLayout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    //横向 间隔
    flowLayout.minimumInteritemSpacing = 0;
    //纵向 间隔
    flowLayout.minimumLineSpacing = 0;

    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    [self addSubview:_collectionView];
    
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    
    // CollectionView registerClass  注册 单元格
    [self registerCollectionViewCellClass];
    
    if ([_sourceData count] > 1) {
        
        CGFloat pageWidth = (_sourceData.count - 2) * 18;
        
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.frame = CGRectMake(self.bounds.size.width - pageWidth, 0.91 * self.bounds.size.height, pageWidth, 8);
        
        self.pageControl.userInteractionEnabled = NO;
        self.pageControl.numberOfPages = _sourceData.count > 1 ? _sourceData.count - 2 : _sourceData.count;
        self.pageControl.currentPage = 0;
        [self addSubview:self.pageControl];
        
        [self setPageControlPageIndicatorTintColor:RGBA(255, 255, 255, .5)];
        [self setPageControlCurrentPageIndicatorTintColor:[UIColor whiteColor]];
        
    }
    
    if (_sourceData.count > 1) {
        _collectionView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    }
    
    if (_sourceData.count == 0) {
        _collectionView.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    }
}

- (void)registerCollectionViewCellClass
{
    [_collectionView registerClass:[LoopCollectionCell class] forCellWithReuseIdentifier:kIdentifier];
}

//自动滚动
- (void)autoScroll
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoScroll) object:nil];
    
    if ([_sourceData count]>1 && self.isAuto)
    {
        CGFloat targetX = _collectionView.contentOffset.x + _collectionView.frame.size.width;
        
        targetX = (int)(targetX/ITEM_WIDTH) * ITEM_WIDTH;
        [self moveToTargetPosition:targetX];
        [self performSelector:@selector(autoScroll) withObject:nil afterDelay:self.timeInterval];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _sourceData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LoopCollectionCell *cell = (LoopCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    
    NSString *valueStr = _sourceData[indexPath.row];
    
    [cell layoutCollectionViewCell:valueStr];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    NSInteger index = indexPath.row - 1;
    
    // 点击 事件 回调
    if ([_loopDelegate respondsToSelector:@selector(loopCollectionView:didSelectItem:)]) {
      
        [_loopDelegate loopCollectionView:self didSelectItem:index];
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 按照坐标移动到scrollView的某个位置
- (void)moveToTargetPosition:(CGFloat)targetX
{
    BOOL animated = YES;
    [_collectionView setContentOffset:CGPointMake(targetX, 0) animated:animated];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float targetX = scrollView.contentOffset.x;

    if ([_sourceData count] >= 3) {
        if (targetX >= ITEM_WIDTH * ([_sourceData count] -1)) {  // 向后滑 最后 一张了 , 循环到第一张
            targetX = ITEM_WIDTH;
            [_collectionView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
        else if(targetX <= 0) {  // 向前滑, 第一张了, 循环到 最后一张
            
            targetX = ITEM_WIDTH *([_sourceData count]-2);
            [_collectionView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
    }
    
    int page = (_collectionView.contentOffset.x+ITEM_WIDTH/2.0) / ITEM_WIDTH;
    
    if ([_sourceData count] > 1) {
        page --;
        if (page >= _pageControl.numberOfPages) {
            page = 0;
        }
        else if(page <0) {
            page = _pageControl.numberOfPages - 1;
        }
    }
    if (page!= _pageControl.currentPage) {
        if ([_loopDelegate respondsToSelector:@selector(loopCollectionView:currentItem:)]) {
            [_loopDelegate loopCollectionView:self currentItem:page];
        }
        _pageControl.currentPage = page;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        CGFloat targetX = _collectionView.contentOffset.x + _collectionView.frame.size.width;
        targetX = (int)(targetX/ITEM_WIDTH) * ITEM_WIDTH;
        [self moveToTargetPosition:targetX];
    }
}

- (void)scrollToIndex:(int)aIndex
{
    if ([_sourceData count] > 1) {
        
        if (aIndex >= ([_sourceData count]- 2)) {
            aIndex = [_sourceData count] - 3;
        }
        [self moveToTargetPosition:ITEM_WIDTH * (aIndex+1)];
        
    }
    else {
        [self moveToTargetPosition:0];
    }
    
    [self scrollViewDidScroll:_collectionView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
