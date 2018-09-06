//
//  BaseWebViewController.h
//
//  Created by 侯佩岑 on 2018/4/24.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "BaseViewController.h"
@import WebKit;

@interface BaseWebViewController : BaseViewController

/// getter返回当前加载的url，setter会reload
@property (nonatomic,copy) NSString* urlString;

/// 内置的webView
@property (nonatomic,strong) WKWebView* webView;

/// 是否使用网页的标题
@property (nonatomic,assign) BOOL useWebTitle;

/**
 *  带标题和URL初始化webVC
 *
 *  @param title 标题
 *  @param urlString   路径
 *  @param use 是否使用网页的标题
 *
 *  @return webVC
 */
- (instancetype)initWithTitle:(NSString*)title
                          url:(NSString*)urlString
                    autoTitle:(BOOL)use;

/**
 下拉刷新会调用此方法
 */
- (void)refreshWebV;
@end
