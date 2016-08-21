//
//  HCCollectionViewLayout.m
//  HCCollectionView
//
//  Created by 光 on 16/8/21.
//  Copyright © 2016年 光. All rights reserved.
//

#import "HCCollectionViewLayout.h"

static NSInteger const DefaultColumnCount = 3;// 列数
static CGFloat const DefaultColumnSpacing = 10;// 列间距
static CGFloat const DefaultRowSpacing = 10;// 行间距
static UIEdgeInsets const DefaultEdgeInsets = {10, 10, 10, 10};// 记录item边距

@interface HCCollectionViewLayout ()

@property (nonatomic, strong) NSMutableArray *attributeArray;

@property (nonatomic, strong) NSMutableArray *maxYArray;// 每一列item的长度

@end

/**
 *  布局效果：
    1.同宽，高不同
    2.紧挨着最短的item
 */
@implementation HCCollectionViewLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    [self.attributeArray removeAllObjects];
    [self.maxYArray removeAllObjects];
    // 初始化maxYArray，用于接下来的比较
    for (NSInteger i = 0; i < DefaultColumnCount; i++) {
        [self.maxYArray addObject:@(DefaultEdgeInsets.top)];
    }
    
    
    // 获取section 0 所有 item 的数量
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    // 自定义item布局
    for (NSInteger i = 0; i < itemCount; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [self.attributeArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }

}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 每一次滑动collectionView，都会进入这个方法，获取item的布局
    return self.attributeArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // item 布局，布局效果的核心计算
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger __block minHeightColum = 0;// 最短的item列号
    CGFloat __block minHeight = [self.maxYArray[minHeightColum] floatValue];
    
    [self.maxYArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat currentHeight = [(NSNumber *)obj floatValue];
        
        if (minHeight > currentHeight) {
            minHeight = currentHeight;
            minHeightColum = idx;
        }
    }];
    CGFloat width = (CGRectGetWidth(self.collectionView.frame) - DefaultEdgeInsets.left - DefaultEdgeInsets.right - DefaultColumnSpacing * (DefaultColumnCount - 1)) / DefaultColumnCount;
    
    CGFloat height = 100 + arc4random_uniform(150);
    
    CGFloat originX = DefaultEdgeInsets.left + (width + DefaultColumnSpacing) * minHeightColum;
    CGFloat originY = minHeight;
    // 判断是否为第一行
    if (originY != DefaultEdgeInsets.top) {
        originY += DefaultRowSpacing;
    }
    
    [attribute setFrame:CGRectMake(originX, originY, width, height)];
    
    self.maxYArray[minHeightColum] = @(CGRectGetMaxY(attribute.frame));
    
    return attribute;
}

- (CGSize)collectionViewContentSize
{
    CGFloat __block maxHeight = 0;
    
    [self.maxYArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat currentHeight = [(NSNumber *)obj floatValue];
        
        if (maxHeight < currentHeight) {
            maxHeight = currentHeight;
        }
    }];
    
    return CGSizeMake(0, maxHeight + DefaultEdgeInsets.bottom);
}

#pragma mark - 懒加载
- (NSMutableArray *)attributeArray
{
    if (!_attributeArray) {
        _attributeArray = [[NSMutableArray alloc] init];
    }
    return _attributeArray;
}

- (NSMutableArray *)maxYArray
{
    if (!_maxYArray) {
        _maxYArray = [[NSMutableArray alloc] init];
    }
    return _maxYArray;
}



@end
