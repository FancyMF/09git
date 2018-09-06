//
//  SignNameView.m
//  SSLift
//
//  Created by 侯佩岑 on 2018/5/18.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "SignNameView.h"
#import "DrawView.h"
#import "BaseMaskWindow.h"

@interface SignNameView ()

@property (nonatomic, strong) BaseMaskWindow * m_window;

@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UIView * toolView;
@property (nonatomic, strong) UILabel * titleLbl;
@property (nonatomic, strong) UIButton * cancleBtn;
@property (nonatomic, strong) UIButton * confirmBtn;

@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, strong) DrawView * drawView;


@end

@implementation SignNameView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.m_window = [BaseMaskWindow shareMaskWindow];
        self.frame = self.m_window.bounds;
        
    }
    return self;
}

-(void)show
{
    [_m_window show];
    [_m_window addSubview:self];
    
    [self addSubview:self.contentView];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.contentView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)-self.contentView.frame.size.height, CGRectGetWidth([UIScreen mainScreen].bounds) , self.contentView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)close
{
    [UIView animateWithDuration:0.3f animations:^{
        
        self.contentView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds) , self.contentView.frame.size.height);
        
    } completion:^(BOOL finished) {
        [_m_window dismiss];
        [self removeFromSuperview];
    }];
}

#pragma mark - 点击方法
-(void)clearImage{
    [self.drawView clearAllLayer];
}

/// 保存按钮点击方法
- (void)saveBtnClick {
    NSLog(@"点击了保存");
    UIImage * image = [self.drawView cutTheView];
    if (image) {
        if (self.selectedBlock) {
            self.selectedBlock([image copy]);
        }
    }else{
        if (self.selectedBlock) {
            self.selectedBlock(nil);
        }
    }
    [self close];
}


#pragma mark - 懒加载
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight(), kScreenWidth(), 300+kSafeAreaBottomHeight())];
        _contentView.backgroundColor = [UIColor whiteColor];
        [_contentView addSubview:self.toolView];
        [_contentView addSubview:self.bgImageView];
        [_contentView addSubview:self.drawView];
        
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.toolView.mas_bottom).offset(12);
            make.left.equalTo(@12);
            make.right.equalTo(_contentView.mas_right).offset(-12);
            make.bottom.equalTo(_contentView.mas_bottom).offset(-12-kSafeAreaBottomHeight());
        }];
        
        [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.toolView.mas_bottom).offset(12);
            make.left.equalTo(@12);
            make.right.equalTo(_contentView.mas_right).offset(-12);
            make.bottom.equalTo(_contentView.mas_bottom).offset(-12-kSafeAreaBottomHeight());
        }];
    }
    return _contentView;
}

-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"signature_bg"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bgImageView;
}

-(DrawView *)drawView{
    if (!_drawView) {
        _drawView = [[DrawView alloc] init];
        _drawView.backgroundColor = [UIColor clearColor];
    }
    return _drawView;
}


- (UIView *)toolView{
    if (!_toolView) {
        _toolView = [[UIView alloc] init];
        _toolView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 50);
        
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = kColorLine();
        [_toolView addSubview:lineView];
        
        [_toolView addSubview:self.cancleBtn];
        [_toolView addSubview:self.confirmBtn];
        [_toolView addSubview:self.titleLbl];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_toolView.mas_bottom);
            make.left.mas_equalTo(_toolView.mas_left);
            make.width.mas_equalTo(_toolView);
            make.height.mas_equalTo(0.7);
        }];
        
        [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_toolView).offset(24);
            make.centerY.mas_equalTo(_toolView);
            make.size.mas_equalTo(CGSizeMake(40, 30));
        }];
        
        [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_toolView).offset(-24);
            make.centerY.mas_equalTo(_toolView);
            make.size.mas_equalTo(CGSizeMake(40, 30));
        }];
        
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cancleBtn.mas_right);
            make.right.mas_equalTo(self.confirmBtn.mas_left);
            make.top.bottom.mas_equalTo(_toolView);
        }];
    }
    return _toolView;
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = kFontSysterm16();
        _titleLbl.text = @"电子签名";
    }
    return _titleLbl;
}


- (UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:@"清除"];
        NSRange allRange = {0,attribute.length};
        [attribute addAttributes:@{NSForegroundColorAttributeName:kColorTheme(),
                                   NSFontAttributeName:kFontSysterm16()} range:allRange];
        [_cancleBtn setAttributedTitle:attribute forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(clearImage) forControlEvents:UIControlEventTouchUpInside];
        _cancleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _cancleBtn;
}


- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:@"確定"];
        NSRange allRange = {0,attribute.length};
        [attribute addAttributes:@{NSForegroundColorAttributeName:kColorTheme(),
                                   NSFontAttributeName:kFontSysterm16()} range:allRange];
        [_confirmBtn setAttributedTitle:attribute forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _confirmBtn;
}

@end
