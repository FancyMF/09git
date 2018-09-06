//
//  WeakScriptMessageDelegate.h
//  为解决WKWebView不释放而生的类

#import <Foundation/Foundation.h>
@import WebKit;

@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)delegate;

@end
