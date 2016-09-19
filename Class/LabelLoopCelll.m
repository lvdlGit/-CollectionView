//
//  LabelLoopCell.m
//  LoopScrollView
//
//  Created by lvdl on 15/11/4.
//  Copyright © 2015年 www.palcw.com. All rights reserved.
//

#import "LabelLoopCell.h"

@interface LabelLoopCell ()

@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation LabelLoopCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor cyanColor];
      
        [self createView];
    }
    return self;
}

- (void)createView
{
    _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [self.contentView addSubview:_valueLabel];
    
    _valueLabel.textColor = [UIColor redColor];
    _valueLabel.font = [UIFont systemFontOfSize:48];
    _valueLabel.textAlignment = NSTextAlignmentCenter;
    
    _valueLabel.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

- (void)layoutCollectionViewCell:(NSString *)valueStr
{
    _valueLabel.text = valueStr;
}

@end
