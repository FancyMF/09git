//
//  BaseWebViewController.m
//
//  Created by 侯佩岑 on 2018/4/24.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "BaseWebViewController.h"
#import "WeakScriptMessageDelegate.h"
#import "Masonry.h"

@interface BaseWebViewController () <WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

/// 加载进度条
@property (strong,nonatomic) UIProgressView* progressLine;

@end

@implementation BaseWebViewController
{
    BOOL _firstLoad;
}

static NSString* const titleString = @"title";
static NSString* const progressString = @"estimatedProgress";

static NSString* const appModel = @"app";


- (instancetype)initWithTitle:(NSString *)title
                          url:(NSString *)urlString
                    autoTitle:(BOOL)use{
    self = [super init];
    if (self) {
        self.title = title;
        _urlString = urlString;
        _useWebTitle = use;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.urlString || self.urlString.length <= 0) {
//        self.urlString = @"https://wap.baidu.com";
    }
    
    WKWebViewConfiguration* config = [WKWebViewConfiguration new];
    // Webview的偏好设置
    config.preferences = [WKPreferences new];
    config.preferences.minimumFontSize = 12;
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    config.userContentController = [WKUserContentController new];
    
    // 添加一个对象名称，可以在JS通过这个名称发送消息
    // window.webkit.messageHandlers.app.postMessage(jsonString)
    WeakScriptMessageDelegate* delegate = [[WeakScriptMessageDelegate alloc] initWithDelegate:self];
    [config.userContentController addScriptMessageHandler:delegate name:appModel];
    
    //    // 添加cookie
    //    config.processPool = [[WKProcessPool alloc] init];
    //    NSString *cookieValue = @"document.cookie = 'fromapp=ios';document.cookie = 'channel=appstore';";
    //    WKUserScript * cookieScript = [[WKUserScript alloc]
    //                                   initWithSource: cookieValue
    //                                   injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    //    [config.userContentController addUserScript:cookieScript];
    
    // 添加webView
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    [self.view addSubview:_webView];
    
    _firstLoad = YES;
    if (_urlString) {
//        [AceHUD defaultIndicatorToView:_webView];
        [self loadUrl:_urlString];
    }
    
    // 添加进度条
    _progressLine = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressLine.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 2.0);
    _progressLine.trackTintColor = [UIColor colorWithWhite:1 alpha:0];
    _progressLine.progressTintColor = kColorTheme();
    [self.view addSubview:_progressLine];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(@0);
    }];
    [_progressLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(@2);
    }];
    
    // KVO
    if (_useWebTitle) {
        [_webView addObserver:self forKeyPath:titleString options:NSKeyValueObservingOptionNew context:nil];
    }
    [_webView addObserver:self forKeyPath:progressString options:NSKeyValueObservingOptionNew context:nil];
}

//- (NSURLRequest*)requestWithCookieAndUrl:(NSString*)url{
//    NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
//
//    NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//
//    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//        [cookieDic setObject:cookie.value forKey:cookie.name];
//    }
//
//    for (NSString *key in cookieDic) {
//        NSString *appendString = [NSString stringWithFormat:@"%@=%@;", key, [cookieDic valueForKey:key]];
//        [cookieValue appendString:appendString];
//    }
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [request addValue:cookieValue forHTTPHeaderField:@"Cookie"];
//
//    return request;
//}

//-(void)returnClick:(id)sender
//{
//    if([self.webView canGoBack])
//
//    {
//
//        [self.webView goBack];
//
//    }
//
//    else
//
//    {
//
//        [self.navigationController popViewControllerAnimated:YES];
//
//    }
//
//}


- (void)stopLoading{
    if ([_webView isLoading]){
        [_webView stopLoading];
//        [_webView.scrollView headerEndRefresh];
//        [AceHUD hidden];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopLoading];
}

- (void)refreshWebV{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString] cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:kTimeoutInterval]];
}
- (void)setUrlString:(NSString*)url{
    if ([_urlString isEqualToString:url] || url == nil) {
        return;
    }
    
    _urlString = url;
    [self loadUrl:url];
}
- (void)loadUrl:(NSString*)url{
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:kTimeoutInterval];
    [_webView loadRequest:request];
    _progressLine.hidden = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
        return NO;
    }
    return YES;
}
- (void)endRefresh{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
//    [_webView.scrollView headerEndRefresh];
//    [AceHUD hidden];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _progressLine.hidden = YES;
    });
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:titleString]) {
        if (_useWebTitle) {
            self.title = _webView.title;
        }
    }else if ([keyPath isEqualToString:progressString]) {
        [_progressLine setProgress:_webView.estimatedProgress animated:YES];
    }
}

/// JS调用的Alert、Confirm、TextInput转换为原生UI
#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:kAlertSure style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:kAlertSure style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:kAlertCancel style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:prompt message:defaultText preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:kAlertSure style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([alert.textFields firstObject].text);
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/// JS调用原生方法
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
//    if ([message.name isEqualToString:appModel]) {
//        id jsonObj = message.body;
//        [AceJavaScriptTool javascriptCall:jsonObj];
//    }
}
/// 导航相关
#pragma mark - WKNavigationDelegate
/**
 决定导航的动作，通常用于处理跨域的链接能否导航。
 WebKit对跨域进行了安全检查限制，不允许跨域，因此我们要对不能跨域的链接单独处理
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

/**
 开始加载页面内容时会回调此代理方法
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    _progressLine.hidden = NO;
    if (_firstLoad){
//        [AceHUD defaultIndicatorToView:_webView];
        _firstLoad = NO;
        
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

/**
 是否允许导航响应，如果不允许就不会跳转到该链接的页面
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/**
 在页面内容加载到达mainFrame时会回调此API。
 如果我们要在mainFrame中注入什么JS，也可以在此处添加。
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{

}

/**
 跳转新页面时调用
 */
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

/**
 加载完毕的回调
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [self endRefresh];
}

/**
 加载失败的回调
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error{
    [self endRefresh];
}

/**
 重定向时回调
 */
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
//
//}

/**
 证书授权改变时回调
 */
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
//
//}

/**
 页面终止加载时回调
 */
//- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
//
//}

- (void)dealloc{
    
    if (_useWebTitle) {
        [_webView removeObserver:self forKeyPath:titleString];
    }
    
    [_webView.configuration.userContentController removeAllUserScripts];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:appModel];
    [_webView removeObserver:self forKeyPath:progressString];
}

@end
