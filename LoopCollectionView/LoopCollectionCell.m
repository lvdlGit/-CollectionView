//
//  LoopCollectionCell.m
//  LoopScrollView
//
//  Created by lvdl on 15/11/4.
//  Copyright © 2015年 www.palcw.com. All rights reserved.
//

#import "LoopCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface LoopCollectionCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LoopCollectionCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self createView];
    }
    return self;
}

- (void)createView
{
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:_imageView];
}

- (void)layoutCollectionViewCell:(NSString *)valueStr
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:valueStr]]) {
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:valueStr]];
    }
    else {
        
        _imageView.image = [UIImage imageNamed:valueStr];
    }
}

@end
