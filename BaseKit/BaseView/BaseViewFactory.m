//
//  BaseViewFactory.m
//  SSLift
//
//  Created by 侯佩岑 on 2018/5/15.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "BaseViewFactory.h"

@implementation BaseViewFactory

+(UIView *)creatImageUpLoadViewWithTitle:(NSString *)title withPlaceImageName:(NSString *)imageName withToIndexRemineTextColor:(NSInteger)index isShowLine:(BOOL)show finish:(void(^)(UIImageView * imageView,UILabel * titleLabel,UIView * lineView))finishBlock{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), 115)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UIImageView * centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [bgView addSubview:centerImageView];
    
    UILabel * titleLabel = [BaseViewFactory creatDefaultLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    if (title.length > 0) {
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:kFontSize(15),NSForegroundColorAttributeName:kColorValue(0x54aff1)}];
        [string setAttributes:@{NSForegroundColorAttributeName:kColorTextDefault()} range:NSMakeRange(0, index)];
        titleLabel.attributedText = string;
    }
    [bgView addSubview:titleLabel];
    
    
    [centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.centerX.equalTo(bgView);
        make.width.mas_equalTo(142);
        make.height.mas_equalTo(94);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerImageView.mas_bottom).offset(19);
        make.centerX.equalTo(bgView);
        make.width.mas_equalTo(bgView.mas_width);
        make.height.mas_equalTo(15);
    }];
    
    UIView * lineView = nil;
    if (show){
        lineView = [[UIView alloc] init];
        lineView.backgroundColor = kColorLine();
        [bgView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bgView);
            make.left.equalTo(@24);
            make.right.equalTo(bgView).offset(-24);
            make.height.mas_equalTo(0.7);
        }];
    }
    
    finishBlock(centerImageView, titleLabel, lineView);
    return bgView;
}

#pragma mark- 标题
+(UIView *)creatHeadViewWithTitle:(NSString *)title withLine:(BOOL)lineShow withTextColor:(UIColor *)color{
    if (!title || title.length <= 0) {
        title = @"";
    }
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), 50)];
    
    UILabel * titleLabel = [[self class] creatDefaultLabelWithTitle:title];
    titleLabel.font = kFontSize(14);
    titleLabel.textColor = color?:kColorTextDefault();
    [backView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(0);
        make.left.mas_equalTo(kSpaceToLeft());
        make.width.equalTo(backView).offset(-30);
        make.height.equalTo(backView);
    }];
    
    if (lineShow) {
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = kColorLine();
        [backView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(backView).offset(0);
            make.left.equalTo(titleLabel.mas_left).offset(0);
            make.right.equalTo(backView).offset(-kSpaceToLeft());
            make.height.equalTo(@0.7);
        }];
    }
    return backView;
}


#pragma mark- label


+(UIView *)creatViewWithTitle:(NSString *)title withRightImageName:(NSString *)imageName height:(CGFloat)height withLine:(BOOL)isShowLine finishBlock:(void (^)(UIImageView *leftImageView, UILabel *label, UILabel *subLabel, UIImageView *rightImageView, UIView *lineView))finishBlock{
    return [[self class] creatViewWithLeftImageName:@"" WithTitle:title withTitleWidth:150 withRightImageName:imageName height:height withLine:isShowLine finishBlock:finishBlock];
}

+(UIView *)creatViewWithLeftImageName:(NSString *)leftImageName WithTitle:(NSString *)title withTitleWidth:(CGFloat)width withFillLabel:(NSString *)filltitle withRightImageName:(NSString *)rightImageName height:(CGFloat)height withLine:(BOOL)isShowLine spaceToEdge:(CGFloat)edge andspaceToOther:(CGFloat)other finishBlock:(void (^)(UIImageView * leftImageView, UILabel * label, UILabel * subLabel, UIImageView * rightImageView, UIView * lineView))finishBlock{
    CGFloat spaceToEdge = edge;
    CGFloat spaceToOther = other;
    CGFloat lineHeight = 0.7;
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), MAX(50,height))];
    backView.backgroundColor = [UIColor whiteColor];
    
    UIImageView * leftImageView;
    CGFloat spaceToLeft = spaceToEdge;
    if (leftImageName && leftImageName.length > 0) {
        
        UIImage * image = [UIImage imageNamed:leftImageName];
        if (image) {
            leftImageView = [[UIImageView alloc] initWithImage:image];
            leftImageView.backgroundColor = [UIColor whiteColor];
            leftImageView.contentMode = UIViewContentModeScaleAspectFit;
            [backView addSubview:leftImageView];
            spaceToLeft += MIN(height, image.size.width);
        }
        
        if (leftImageView) {
            [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.bottom.equalTo(@0);
                make.right.equalTo(backView.mas_left).offset(spaceToLeft);
                make.width.mas_equalTo(image.size.width);
            }];
        }
    }
    
    UILabel * titleLabel = [[self class] creatDefaultLabelWithTitle:title];
    [backView addSubview:titleLabel];
    
    UILabel * fillLabel = [[self class] creatDefaultLabelWithTitle:@""];
    fillLabel.textColor = kColorTextLightGray();
    fillLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:fillLabel];
    
    UIImageView * rightImageView;
    CGFloat spaceToRight = -spaceToEdge;
    if (rightImageName && rightImageName.length > 0) {
        
        UIImage * image = [UIImage imageNamed:rightImageName];
        if (image) {
            rightImageView = [[UIImageView alloc] initWithImage:image];
            rightImageView.backgroundColor = [UIColor whiteColor];
            rightImageView.contentMode = UIViewContentModeScaleAspectFit;
            [backView addSubview:rightImageView];
            spaceToRight -= MIN(height, image.size.width);
        }
        
        if (rightImageView) {
            [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.bottom.equalTo(@0);
                make.left.equalTo(backView.mas_right).offset(spaceToRight);
                make.width.mas_equalTo(image.size.width);
            }];
        }
    }
    
    UIView * lineView;
    if (isShowLine) {
        lineView = [[UIView alloc] init];
        lineView.backgroundColor = kColorLine();
        [backView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(backView);
            make.left.equalTo(backView).offset(spaceToEdge);
            make.right.equalTo(backView).offset(-spaceToEdge);
            make.height.mas_equalTo(lineHeight);
        }];
    }
    
    CGFloat offset = 0;
    if (leftImageView) {
        offset = spaceToOther;
    }else{
        offset = 0;
    }
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(backView).offset(spaceToLeft+offset);
        make.width.mas_equalTo(MAX(50,width));
    }];
    
    if (rightImageView) {
        offset = spaceToOther;
    }else{
        offset = 0;
    }
    
    [fillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(titleLabel.mas_right).offset(offset);
        make.right.equalTo(backView).offset(spaceToRight-offset);
    }];
    
    
    finishBlock(leftImageView,titleLabel,fillLabel,rightImageView,lineView);
    
    //test
    //    titleLabel.text = @"标题";
    //    fillLabel.text = @"内容";
    return backView;

    
}

+(UIView *)creatViewWithLeftImageName:(NSString *)leftImageName WithTitle:(NSString *)title withTitleWidth:(CGFloat)width withRightImageName:(NSString *)rightImageName height:(CGFloat)height withLine:(BOOL)isShowLine spaceToEdge:(CGFloat)edge andspaceToOther:(CGFloat)other finishBlock:(void (^)(UIImageView * leftImageView, UILabel * label, UILabel * subLabel, UIImageView * rightImageView, UIView * lineView))finishBlock{
    return [[self class]creatViewWithLeftImageName:leftImageName WithTitle:title withTitleWidth:width withFillLabel:@"" withRightImageName:rightImageName height:height withLine:isShowLine spaceToEdge:edge andspaceToOther:other finishBlock:finishBlock];
    
}

//+(UIView *)creatViewWithLeftImageName:(NSString *)leftImageName WithTitle:(NSString *)title withTitleWidth:(CGFloat)width withRightLabel:(NSString *)rightLabelName height:(CGFloat)height  {
//    CGFloat spaceToEdge = 18;
//    CGFloat spaceToOther = 20;
//   
//    
//    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), MAX(50,height))];
//    backView.backgroundColor = [UIColor clearColor];
//    
//    UIButton * leftBtn;
//    CGFloat spaceToLeft = spaceToEdge;
//    if (leftImageName && leftImageName.length > 0) {
//        leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        leftBtn.backgroundColor = [UIColor clearColor];
//        
//        UIImage * image = [UIImage imageNamed:leftImageName];
//        if (image) {
//            leftBtn.contentMode = UIViewContentModeScaleAspectFit;
//            [leftBtn setImage:image forState:UIControlStateNormal];
//            
//            spaceToLeft += MIN(height, image.size.width);
//        }
//        else{
//            [leftBtn setTitle:leftImageName forState:UIControlStateNormal];
//            
//        }
//        
//        [backView addSubview:leftBtn];
//        if (leftBtn) {
//            [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(@0);
//                make.bottom.equalTo(@0);
//                make.right.equalTo(backView.mas_left).offset(spaceToLeft);
//                make.width.mas_equalTo(image.size.width);
//            }];
//        }
//    }
//    
//    UILabel * titleLabel = [[self class] creatDefaultLabelWithTitle:title];
//    [backView addSubview:titleLabel];
//    
// 
//    
//    UIButton * rightBtn;
//    CGFloat spaceToRight = -spaceToEdge;
//    if (rightLabelName && rightLabelName.length > 0) {
//        
//        UIImage * image = [UIImage imageNamed:rightLabelName];
//        if (image) {
//            rightImageView = [[UIImageView alloc] initWithImage:image];
//            rightImageView.backgroundColor = [UIColor whiteColor];
//            rightImageView.contentMode = UIViewContentModeScaleAspectFit;
//            [backView addSubview:rightImageView];
//            spaceToRight -= MIN(height, image.size.width);
//        }
//        
//        if (rightImageView) {
//            [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(@0);
//                make.bottom.equalTo(@0);
//                make.left.equalTo(backView.mas_right).offset(spaceToRight);
//                make.width.mas_equalTo(image.size.width);
//            }];
//        }
//    }
//    
//    
////    CGFloat offset = 0;
////    if (leftImageView) {
////        offset = spaceToOther;
////    }else{
////        offset = 0;
////    }
//    
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@0);
//        make.bottom.equalTo(@0);
//        make.center.equalTo(backView).offset(spaceToLeft+offset);
//        make.width.mas_equalTo(MAX(50,width));
//    }];
//    
//    if (rightImageView) {
//        offset = spaceToOther;
//    }else{
//        offset = 0;
//    }
//    
//
//    
//
//    return backView;
//    
//}
+(UIView *)creatViewWithLeftImageName:(NSString *)leftImageName WithTitle:(NSString *)title withTitleWidth:(CGFloat)width withRightImageName:(NSString *)rightImageName height:(CGFloat)height withLine:(BOOL)isShowLine finishBlock:(void (^)(UIImageView * leftImageView, UILabel * label, UILabel * subLabel, UIImageView * rightImageView, UIView * lineView))finishBlock{
    return [[self class] creatViewWithLeftImageName:leftImageName WithTitle:title withTitleWidth:width withRightImageName:rightImageName height:height withLine:isShowLine spaceToEdge:20 andspaceToOther:20 finishBlock:finishBlock];
}

#pragma mark- textField
+(UIView *)creatTextFieldViewWithTitle:(NSString *)title withPlaceHolder:(NSString *)placeHolder height:(CGFloat)height withLineShow:(BOOL)lineShow finishBlock:(void (^)(UILabel * label,UITextField * textField))finishBlock{
    return [[self class] creatTextFieldViewWithTitle:title withTitleWidth:80 withPlaceHolder:placeHolder height:height withLineShow:lineShow finishBlock:finishBlock];
}

+(UIView *)creatTextFieldViewWithTitle:(NSString *)title withTitleWidth:(CGFloat)width withPlaceHolder:(NSString *)placeHolder height:(CGFloat)height withLineShow:(BOOL)lineShow finishBlock:(void (^)(UILabel * label,UITextField * textField))finishBlock{
    CGFloat spaceToEdge = 16;
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), MAX(20,height))];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLabel = [[self class] creatDefaultLabelWithTitle:title];
    [backView addSubview:titleLabel];
    
    UITextField * fillTextField = [[self class] creatDefaultTextFieldWithTitle:@"" WithPlaceHolder:@"请输入"];
    fillTextField.textAlignment = NSTextAlignmentRight;
    if (placeHolder && placeHolder.length > 0) {
        fillTextField.placeholder = placeHolder;
    }
    [backView addSubview:fillTextField];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.mas_equalTo(spaceToEdge);
        make.width.mas_equalTo(MAX(80, width));
    }];
    
    [fillTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(titleLabel.mas_right).offset(5);
        make.right.equalTo(backView).offset(-spaceToEdge);
    }];
    
    if (lineShow) {
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = kColorLine();
        [backView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(backView);
            make.left.equalTo(titleLabel);
            make.right.equalTo(backView).offset(-spaceToEdge);
            make.height.equalTo(@0.7);
        }];
    }
    finishBlock(titleLabel,fillTextField);
    return backView;
}

+(UIView *)creatTextFieldViewWithLeftImageName:(NSString *)leftImageName WithTitle:(NSString *)title withTitleWidth:(CGFloat)width withPlaceHolder:(NSString *)placeHolder withRightImageName:(NSString *)rightImageName height:(CGFloat)height withLine:(BOOL)isShowLine finishBlock:(void (^)(UIImageView * leftImageView, UILabel * label, UITextField * textField, UIImageView * rightImageView, UIView * lineView))finishBlock{
    return  [[self class]creatTextFieldViewWithLeftImageName:(NSString *)leftImageName WithTitle:(NSString *)title withTitleWidth:(CGFloat)width withPlaceHolder:(NSString *)placeHolder TextFieldwithTextAlignment:(NSTextAlignment)NSTextAlignmentRight  withRightImageName:(NSString *)rightImageName height:(CGFloat)height withLine:(BOOL)isShowLine finishBlock:(void (^)(UIImageView * leftImageView, UILabel * label, UITextField * textField, UIImageView * rightImageView, UIView * lineView))finishBlock];
}
+(UIView *)TextFieldViewWithLeftImageName:(NSString *)leftImageName WithTitle:(NSString *)title withTitleWidth:(CGFloat)width withPlaceHolder:(NSString *)placeHolder TextFieldwithTextAlignment:(NSTextAlignment)alignment  withRightImageName:(NSString *)rightImageName height:(CGFloat)height withLine:(BOOL)isShowLine WithSpaceToEdge:(CGFloat)spacetoedge SpaceToOther:(CGFloat)spacetoother finishBlock:(void (^)(UIImageView * leftImageView, UILabel * label, UITextField * textField, UIImageView * rightImageView, UIView * lineView))finishBlock{
    CGFloat spaceToEdge = spacetoedge;
    CGFloat spaceToOther = spacetoother;
    CGFloat lineHeight = 0.7;
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), MAX(50,height))];
    backView.backgroundColor = [UIColor whiteColor];
    
    UIImageView * leftImageView;
    CGFloat spaceToLeft = spaceToEdge;
    if (leftImageName && leftImageName.length > 0) {
        
        UIImage * image = [UIImage imageNamed:leftImageName];
        if (image) {
            leftImageView = [[UIImageView alloc] initWithImage:image];
            leftImageView.backgroundColor = [UIColor whiteColor];
            leftImageView.contentMode = UIViewContentModeScaleAspectFit;
            [backView addSubview:leftImageView];
            spaceToLeft += MIN(height, image.size.width);
        }
        
        if (leftImageView) {
            [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.bottom.equalTo(@0);
                make.right.equalTo(backView.mas_left).offset(spaceToLeft);
                make.width.mas_equalTo(image.size.width);
            }];
        }
    }
    
    UILabel * titleLabel = [[self class] creatDefaultLabelWithTitle:title];
    [backView addSubview:titleLabel];
    
    UITextField * fillTextField = [[self class] creatDefaultTextFieldWithTitle:@"" WithPlaceHolder:placeHolder];
    fillTextField.textColor = kColorTextLightGray();
    fillTextField.textAlignment = alignment;
    [backView addSubview:fillTextField];
    
    UIImageView * rightImageView;
    CGFloat spaceToRight = -spaceToEdge;
    if (rightImageName && rightImageName.length > 0) {
        
        UIImage * image = [UIImage imageNamed:rightImageName];
        if (image) {
            rightImageView = [[UIImageView alloc] initWithImage:image];
            rightImageView.backgroundColor = [UIColor whiteColor];
            rightImageView.contentMode = UIViewContentModeScaleAspectFit;
            [backView addSubview:rightImageView];
            spaceToRight -= MIN(height, image.size.width);
        }
        
        if (rightImageView) {
            [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.bottom.equalTo(@0);
                make.left.equalTo(backView.mas_right).offset(spaceToRight);
                make.width.mas_equalTo(image.size.width);
            }];
        }
    }
    
    UIView * lineView;
    if (isShowLine) {
        lineView = [[UIView alloc] init];
        lineView.backgroundColor = kColorLine();
        [backView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(backView);
            make.left.equalTo(backView).offset(spaceToEdge);
            make.right.equalTo(backView).offset(-spaceToEdge);
            make.height.mas_equalTo(lineHeight);
        }];
    }
    
    CGFloat offset = 0;
    if (leftImageView) {
        offset = spaceToOther;
    }else{
        offset = 0;
    }
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(backView).offset(spaceToLeft+offset);
        make.width.mas_equalTo(MAX(50,width));
    }];
    
    if (rightImageView) {
        offset = spaceToOther;
    }else{
        offset = 0;
    }
    
    [fillTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(titleLabel.mas_right).offset(offset);
        make.right.equalTo(backView).offset(spaceToRight-offset);
    }];
    
    
    finishBlock(leftImageView,titleLabel,fillTextField,rightImageView,lineView);
    
    
    return backView;
    
    
}
+(UIView *) creatTextFieldViewWithLeftImageName:(NSString *)leftImageName WithTitle:(NSString *)title withTitleWidth:(CGFloat)width withPlaceHolder:(NSString *)placeHolder TextFieldwithTextAlignment:(NSTextAlignment)alignment  withRightImageName:(NSString *)rightImageName height:(CGFloat)height withLine:(BOOL)isShowLine finishBlock:(void (^)(UIImageView * leftImageView, UILabel * label, UITextField * textField, UIImageView * rightImageView, UIView * lineView))finishBlock{
    CGFloat spaceToEdge = 16;
    CGFloat spaceToOther = 10;
    CGFloat lineHeight = 0.7;
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), MAX(50,height))];
    backView.backgroundColor = [UIColor whiteColor];
    
    UIImageView * leftImageView;
    CGFloat spaceToLeft = spaceToEdge;
    if (leftImageName && leftImageName.length > 0) {
        
        UIImage * image = [UIImage imageNamed:leftImageName];
        if (image) {
            leftImageView = [[UIImageView alloc] initWithImage:image];
            leftImageView.backgroundColor = [UIColor whiteColor];
            leftImageView.contentMode = UIViewContentModeScaleAspectFit;
            [backView addSubview:leftImageView];
            spaceToLeft += MIN(height, image.size.width);
        }
        
        if (leftImageView) {
            [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.bottom.equalTo(@0);
                make.right.equalTo(backView.mas_left).offset(spaceToLeft);
                make.width.mas_equalTo(image.size.width);
            }];
        }
    }
    
    UILabel * titleLabel = [[self class] creatDefaultLabelWithTitle:title];
    [backView addSubview:titleLabel];
    
    UITextField * fillTextField = [[self class] creatDefaultTextFieldWithTitle:@"" WithPlaceHolder:placeHolder];
    fillTextField.textColor = kColorTextLightGray();
    fillTextField.textAlignment = alignment;
    [backView addSubview:fillTextField];
    
    UIImageView * rightImageView;
    CGFloat spaceToRight = -spaceToEdge;
    if (rightImageName && rightImageName.length > 0) {
        
        UIImage * image = [UIImage imageNamed:rightImageName];
        if (image) {
            rightImageView = [[UIImageView alloc] initWithImage:image];
            rightImageView.backgroundColor = [UIColor whiteColor];
            rightImageView.contentMode = UIViewContentModeScaleAspectFit;
            [backView addSubview:rightImageView];
            spaceToRight -= MIN(height, image.size.width);
        }
        
        if (rightImageView) {
            [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.bottom.equalTo(@0);
                make.left.equalTo(backView.mas_right).offset(spaceToRight);
                make.width.mas_equalTo(image.size.width);
            }];
        }
    }
    
    UIView * lineView;
    if (isShowLine) {
        lineView = [[UIView alloc] init];
        lineView.backgroundColor = kColorLine();
        [backView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(backView);
            make.left.equalTo(backView).offset(spaceToEdge);
            make.right.equalTo(backView).offset(-spaceToEdge);
            make.height.mas_equalTo(lineHeight);
        }];
    }
    
    CGFloat offset = 0;
    if (leftImageView) {
        offset = spaceToOther;
    }else{
        offset = 0;
    }
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(backView).offset(spaceToLeft+offset);
        make.width.mas_equalTo(MAX(50,width));
    }];
    
    if (rightImageView) {
        offset = spaceToOther;
    }else{
        offset = 0;
    }
    
    [fillTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(titleLabel.mas_right).offset(offset);
        make.right.equalTo(backView).offset(spaceToRight-offset);
    }];
    
    
    finishBlock(leftImageView,titleLabel,fillTextField,rightImageView,lineView);
    
    //test
    //    titleLabel.text = @"标题";
    //    fillTextField.text = @"内容";
    return backView;
    
}

#pragma mark- button
+(UIButton *)creatButtonWithTitle:(NSString *)title withBackColor:(UIColor *)color withRadius:(CGFloat)radius{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 230, 44);
//    [button setBackgroundImage:[[UIImage imageNamed:@"icon_BG_button"] circleImageWithCornerRadius:MIN([UIImage imageNamed:@"icon_BG_button"].size.height, radius)] forState:UIControlStateNormal];
//    [button setBackgroundImage:[[UIImage imageNamed:@"icon_BG_button"] circleImageWithCornerRadius:MAX(0, [UIImage imageNamed:@"icon_BG_button"].size.height/2)] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"icon_BG_button"] forState:UIControlStateNormal];
    button.backgroundColor = color?color:kColorTheme();
    button.layer.cornerRadius = MAX(3, radius);
    button.layer.masksToBounds = YES;
    button.titleLabel.font = kFontSize(18);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}

+(UIView *)creatButtonViewWithTitle:(NSString *)title withBackColor:(UIColor *)color withRadius:(CGFloat)radius finishBlock:(void (^)(UIButton * button))finishBlock{
    UIView * bgView = [UIView new];
    bgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.shadowColor = [UIColor colorWithWhite:0.3 alpha:1].CGColor;
    bgView.layer.shadowOpacity = 0.1f;
    bgView.layer.shadowRadius = 4.f;
    bgView.layer.shadowOffset = CGSizeMake(0,0);
    
    UIButton * readButton = [BaseViewFactory creatButtonWithTitle:title withBackColor:color?color:kColorTheme() withRadius:radius];
    [bgView addSubview:readButton];
    
    [readButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(8);
        make.left.equalTo(bgView).offset(12);
        make.right.equalTo(bgView).offset(-12);
        make.height.mas_equalTo(44);
    }];
    
    finishBlock(readButton);
    return bgView;
}
////创建宽大默认按钮
//+(UIButton *)creatButtonWithTitle:(NSString *)title withBackColor:(UIColor *)color withRadius:(CGFloat)radius {
//
//    UIButton * RechargeBtn =[BaseViewFactory creatButtonWithTitle:@"充值" withBackColor:kColorTheme() withRadius:22.];
//    [self.view addSubview:RechargeBtn];
//    [RechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view);
//        make.top.mas_equalTo(howMany.mas_bottom).offset(98);
//        make.width.mas_equalTo(300);
//        make.height.mas_equalTo(41);
//    }];
//
//}

#pragma mark- 初始化控件
+(UIView *)creatLineViewWith:(CGFloat)height withColor:(UIColor *)color{
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), MAX(0.7, height))];
    lineView.backgroundColor = color?color:kColorBackground();
    return lineView;
}


+(UILabel *)creatDefaultLabelWithTitle:(NSString *)title{
    UILabel * defaultLabel = [[self class] creatDefaultLabel];
    if (title && title.length > 0) {
        defaultLabel.text = title;
    }
    return defaultLabel;
}

+(UILabel *)creatDefaultLabel{
    UILabel * defaultLabel = [[UILabel alloc] init];
//    defaultLabel.backgroundColor = [UIColor whiteColor];
    defaultLabel.textColor = kColorTextDefault();
    defaultLabel.font = kFontSize(15);
    return defaultLabel;
}

+(UITextField *)creatDefaultTextFieldWithTitle:(NSString *)title WithPlaceHolder:(NSString *)placeHolder{
    UITextField * defaultTextField = [[UITextField alloc] init];
//    defaultTextField.backgroundColor = [UIColor whiteColor];
    defaultTextField.textColor = kColorTextDefault();
    defaultTextField.font = kFontSize(15);
    defaultTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    if (title && title.length > 0) {
        defaultTextField.text = title;
    }
    if (placeHolder) {
        defaultTextField.placeholder = placeHolder;
    }
    return defaultTextField;
}

+(UIImageView *)creatDefaultImageViewWithImageName:(NSString *)imageName{
    UIImageView * imageView = [[UIImageView alloc] init];
//    imageView.backgroundColor = [UIColor whiteColor];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
    if (imageName) {
        UIImage * image = [UIImage imageNamed:imageName];
        if (image) {
            imageView.image = image;
        }else{
//            NSLog(@"no image:%@",imageName);
        }
    }
    return imageView;
}

+(UIButton *)creatDefaultButtonWithTitle:(NSString *)title WithTarget:(id)target WithSEL:(SEL)selector{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor = [UIColor whiteColor];
    button.titleLabel.font = kFontSize(15);
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (target && selector) {
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}
+(UIButton *)creatDefaultButtonWithImage:(NSString*)imagename WithTarget:(id)target WithSEL:(SEL)selector{
UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (imagename) {
        [button setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    }
    if (target && selector) {
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}


#pragma mark- 约束
+(void)addMas_targetView:(UIView *)targetView relationVIew:(UIView *)relationView withOffset:(CGFloat)offset withHeight:(CGFloat)height{
    [targetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(relationView.mas_bottom).offset(offset);
        make.left.equalTo(relationView.mas_left);
        make.width.equalTo(relationView.mas_width);
        make.height.mas_equalTo(height);
    }];
}

+(void)addMas_targetView:(UIView *)targetView relationVIew:(UIView *)relationView withHeight:(CGFloat)height{
    [targetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(relationView.mas_bottom);
        make.left.equalTo(relationView.mas_left);
        make.width.equalTo(relationView.mas_width);
        make.height.mas_equalTo(height);
    }];
}

+(void)addMas_targetView:(UIView *)targetView relationVIew:(UIView *)relationView withTop:(CGFloat)top withHeight:(CGFloat)height{
    [targetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top);
        make.left.equalTo(relationView.mas_left);
        make.width.equalTo(relationView.mas_width);
        make.height.mas_equalTo(height);
    }];
}


#pragma mark- 添加手势
+(void)addTapGestureView:(UIView *)addGestureView WithTagert:(id)target withSEL:(SEL)selector{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    addGestureView.userInteractionEnabled = YES;
    [addGestureView addGestureRecognizer:tap];
}
#pragma mark - 添加虚线
+(UIView *)addImaginaryLineWithFrame:(CGRect)frame lineColor:(UIColor *)color lineHeight:(float)height lineDashWidth:(NSNumber *)width lineDashSpace:(NSNumber *)space {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.position = CGPointMake(0, 1);
    shapeLayer.fillColor = nil;
    
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineWidth = height;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineDashPattern = @[width, space];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 10, 0);
    CGPathAddLineToPoint(path, NULL, kScreenWidth() - 10,0);
    shapeLayer.path = path;
    CGPathRelease(path);
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view.layer addSublayer:shapeLayer];
    view.layer.masksToBounds=YES;
    return view;
}


@end
