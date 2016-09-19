//
//  LabelLoopView.m
//  LoopScrollView
//
//  Created by lvdl on 15/11/4.
//  Copyright © 2015年 www.palcw.com. All rights reserved.
//

#import "LabelLoopView.h"
#import "LabelLoopCell.h"

static NSString *kIdentifier = @"LabelLoopCell";

@implementation LabelLoopView

- (void)registerCollectionViewCellClass
{
    [self.collectionView registerClass:[LabelLoopCell class] forCellWithReuseIdentifier:kIdentifier];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LabelLoopCell *cell = (LabelLoopCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    
    NSString *valueStr = self.sourceData[indexPath.row];
    
    [cell layoutCollectionViewCell:valueStr];
    
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
