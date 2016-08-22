//
//  HCCollectionViewLayout.h
//  HCCollectionView
//
//  Created by 光 on 16/8/21.
//  Copyright © 2016年 光. All rights reserved.
//  collectionView 的布局 

#import <UIKit/UIKit.h>

@class HCCollectionViewLayout;

@protocol HCLayoutDelegate <NSObject>

@required
/**
 *  设置item高
 */
- (CGFloat)hcLayout:(HCCollectionViewLayout *)layout heightForItemAtIndex:(NSUInteger)index withItemWidth:(CGFloat)itemWidth;

@optional
/**
 *  设置列数，默认3
 */
- (NSInteger)hcLayoutColumnCount:(HCCollectionViewLayout *)layout;
/**
 *  设置列间距，默认10
 */
- (CGFloat)hcLayoutColumnSpacing:(HCCollectionViewLayout *)layout;
/**
 *  设置行间距，默认10
 */
- (CGFloat)hcLayoutRowSpacing:(HCCollectionViewLayout *)layout;
/**
 *  设置边距，默认{10,10,10,10}
 */
- (UIEdgeInsets)hcLayoutEdgeInsets:(HCCollectionViewLayout *)layout;

@end

@interface HCCollectionViewLayout : UICollectionViewLayout


@property (nonatomic, weak) id<HCLayoutDelegate> layoutDelegate;


@end
