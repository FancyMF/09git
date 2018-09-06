//
//  WeakScriptMessageDelegate.m
//

#import "WeakScriptMessageDelegate.h"

@interface WeakScriptMessageDelegate ()

@property (weak,nonatomic) id<WKScriptMessageHandler> delegate;

@end

@implementation WeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)delegate{
    self  = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    [_delegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
