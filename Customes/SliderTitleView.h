//
//  ESSliderTitleView.h
//  一个滑动标题栏
//
//  Created by chenpeihang on 16/12/16.
//  Copyright © 2016年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SliderTitleViewDelegate <NSObject>
// 点击
-(void)SliderTitleViewSelectButtonIndex:(NSInteger)index withDataArray:(NSArray *)dataArray;

@end

/// 点击切换的按钮控件
@interface SliderTitleView : UIView
/// 设置默认按钮
@property (nonatomic, assign) NSInteger DefaultSlectIndex;
/// 按钮的字体大小,颜色设置
@property (nonatomic, strong) UIFont * titleFont;
@property (nonatomic, strong) UIColor * unselectColor;
@property (nonatomic, strong) UIColor * selectColor;
/// 未选中和选中图片
@property (nonatomic, strong) UIImage * unselectImage;
@property (nonatomic, strong) UIImage * selectIamge;
/// 是否有下划线
@property (nonatomic, assign) BOOL isBottomImage;

/// 每个标题的宽度 (设置了就按这个宽度,不设置就平均分,若计算超过空间长度就用UIScrollView)
@property (nonatomic, assign) CGFloat eachWidth;
/// 标题按钮间的间距
@property (nonatomic, assign) CGFloat space;

@property (nonatomic, assign) BOOL roundBG;/// 底图 和 按钮 是否设置圆角
@property (nonatomic, strong) UIColor * colorBG; /// 底图背景色

@property (nonatomic, weak) id<SliderTitleViewDelegate> delegate;
/// 设置标题
-(UIView *)setViewWithTitleArray:(NSArray *)array;
/// 点击摸个按钮
-(void)selectButtonOfIndex:(NSInteger)index;




@end
