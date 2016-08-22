//
//  ViewController.m
//  HCCollectionView
//
//  Created by 光 on 16/8/21.
//  Copyright © 2016年 光. All rights reserved.
//

#import "ViewController.h"
#import "HCCollectionViewLayout.h"

static NSString *cellID = @"collectionCellID";

@interface ViewController ()<UICollectionViewDataSource, HCLayoutDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    HCCollectionViewLayout *layout = [[HCCollectionViewLayout alloc] init];
    // 签订协议
    layout.layoutDelegate = self;
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.view addSubview:collectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  cell的样式自定义
     */
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor orangeColor];
    
    NSInteger tag = 10;
    UILabel *label = [cell.contentView viewWithTag:10];
    
    if (!label) {
        label = [[UILabel alloc] init];
        label.tag = tag;
        [cell.contentView addSubview:label];
    }
    
    label.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    [label sizeToFit];
    
    return cell;
}

#pragma mark - HCLayoutDelegate - cell 的 frame
- (CGFloat)hcLayout:(HCCollectionViewLayout *)layout heightForItemAtIndex:(NSUInteger)index withItemWidth:(CGFloat)itemWidth
{
    return arc4random_uniform(200);
}

/**
 *  设置列数，默认3
 */
- (NSInteger)hcLayoutColumnCount:(HCCollectionViewLayout *)layout
{
    return 4;
}
/**
 *  设置列间距，默认10
 */
- (CGFloat)hcLayoutColumnSpacing:(HCCollectionViewLayout *)layout
{
    return 15;
}
/**
 *  设置行间距，默认10
 */
- (CGFloat)hcLayoutRowSpacing:(HCCollectionViewLayout *)layout
{
    return 15;
}
/**
 *  设置边距，默认{10,10,10,10}
 */
- (UIEdgeInsets)hcLayoutEdgeInsets:(HCCollectionViewLayout *)layout
{
    return UIEdgeInsetsMake(20, 10, 20, 10);
}



@end
