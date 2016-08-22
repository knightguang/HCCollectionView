# HCCollectionView
demo for collectionView Layout
<br/>瀑布流的实现效果：
<br/>1、同宽，高不同
<br/>2、行紧凑，下一行以一定间距紧贴上一行
<br/>
<br/>
![](https://github.com/knightguang/HCCollectionView/blob/master/HCCollectionView/1.png)

<br/>签订HCLayoutDelegate协议，根据需求自定义行列数量以其及间距
<br/>

    // 实现协议方法：
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
<br/>
<br/>
![](https://github.com/knightguang/HCCollectionView/blob/master/HCCollectionView/2.png)
