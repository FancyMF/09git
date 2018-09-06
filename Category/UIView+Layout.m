#import "UIView+Layout.h"

@implementation UIView (Layout)

 - (UIViewController *)viewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);

    return (UIViewController *)next;
}

 - (UIView *)topSuperView
{
    UIView *topSuperView = self.superview;

    if (topSuperView == nil) {
        topSuperView = self;
    } else {
        while (topSuperView.superview) {
            topSuperView = topSuperView.superview;
        }
    }

    return topSuperView;
}

#pragma mark - width

- (CGFloat)width{
    return self.bounds.size.width;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
#pragma mark - height

- (CGFloat)height{
    return self.bounds.size.height;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
#pragma mark - x
- (CGFloat)x{
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

#pragma mark - y
- (CGFloat)y{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
#pragma mark - y
- (CGSize)size{
    return self.frame.size;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - origin
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin{
    return self.frame.origin;
}

#pragma mark - maxX
- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

#pragma mark - maxY
- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}
- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

#pragma mark - layout

- (void)setEdgeInsets:(UIEdgeInsets)edge{
    CGSize superSize = self.superview.size;
    self.frame = CGRectMake(edge.left, edge.top, superSize.width - (edge.left + edge.right), superSize.height - (edge.top + edge.bottom));
}

- (CGFloat)bottom
{
    return self.frame.size.height + self.frame.origin.y;
}

- (CGFloat)right
{
    return self.frame.size.width + self.frame.origin.x;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    self.x = left;
}

- (void)setTop:(CGFloat)top
{
    self.y = top;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)heightEqualToView:(UIView *)view
{
    self.height = view.height;
}

- (void)widthEqualToView:(UIView *)view
{
    self.width = view.width;
}

// center
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.y = centerY;
    self.center = center;
}

- (void)centerXEqualToView:(UIView *)view
{
    CGFloat centerX = (self.superview == view) ? view.width/2.0 : view.centerX;
    self.center = CGPointMake(centerX, self.centerY);
}

- (void)centerYEqualToView:(UIView *)view
{
    CGFloat centerY = (self.superview == view) ? view.height/2.0 : view.centerY;
    self.center = CGPointMake(self.centerX, centerY);
}

- (void)centerEqualToView:(UIView *)view
{
    if (self.superview == view) {
        self.center = CGPointMake(view.width/2.0, view.height/2.0);
    }else{
        UIView *superView = view.superview ? view.superview : view;
        CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
        CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
        self.center = centerPoint;
    }
}

// top, bottom, left, right -- Version 1.1.0
- (void)fromTheTop:(CGFloat)distance ofView:(UIView *)view
{
    [self bottom:distance FromView:view];
}

- (void)fromTheBottom:(CGFloat)distance ofView:(UIView *)view
{
    [self top:distance FromView:view];
}

- (void)fromTheLeft:(CGFloat)distance ofView:(UIView *)view
{
    [self left:distance FromView:view];
}

- (void)fromTheRight:(CGFloat)distance ofView:(UIView *)view
{
    [self right:distance FromView:view];
}


- (void)fromTheRelativeTop:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType
{
    [self bottomRatio:distance FromView:view screenType:screenType];
}

- (void)fromTheRelativeBottom:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType
{
    [self topRatio:distance FromView:view screenType:screenType];
}

- (void)fromTheRelativeLeft:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType
{
    [self leftRatio:distance FromView:view screenType:screenType];
}

- (void)fromTheRelativeRight:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType
{
    [self rightRatio:distance FromView:view screenType:screenType];
}


- (void)relativeTopInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    [self topRatioInContainer:top shouldResize:shouldResize screenType:screenType];
}

- (void)relativeBottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    [self bottomRatioInContainer:bottom shouldResize:shouldResize screenType:screenType];
}

- (void)relativeLeftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    [self leftRatioInContainer:left shouldResize:shouldResize screenType:screenType];
}

- (void)relativeRightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    [self rightRatioInContainer:right shouldResize:shouldResize screenType:screenType];
}


// top, bottom, left, right -- Old Version
- (void)top:(CGFloat)top FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = floorf(newOrigin.y + top + view.height);
}

- (void)bottom:(CGFloat)bottom FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y - bottom - self.height;
}

- (void)left:(CGFloat)left FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x - left - self.width;
}

- (void)right:(CGFloat)right FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x + right + view.width;
}

- (void)topRatio:(CGFloat)top FromView:(UIView *)view screenType:(UIScreenType)screenType
{
    CGFloat topRatio = top / screenType;
    CGFloat topValue = topRatio * self.superview.width;
    [self top:topValue FromView:view];
}

- (void)bottomRatio:(CGFloat)bottom FromView:(UIView *)view screenType:(UIScreenType)screenType
{
    CGFloat bottomRatio = bottom / screenType;
    CGFloat bottomValue = bottomRatio * self.superview.width;
    [self bottom:bottomValue FromView:view];
}

- (void)leftRatio:(CGFloat)left FromView:(UIView *)view screenType:(UIScreenType)screenType
{
    CGFloat leftRatio = left / screenType;
    CGFloat leftValue = leftRatio * self.superview.width;
    [self left:leftValue FromView:view];
}

- (void)rightRatio:(CGFloat)right FromView:(UIView *)view screenType:(UIScreenType)screenType
{
    CGFloat rightRatio = right / screenType;
    CGFloat rightValue = rightRatio * self.superview.width;
    [self right:rightValue FromView:view];
}

- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.height = self.y - top + self.height;
    }
    self.y = top;
}

- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.height = self.superview.height - bottom - self.y;
    } else {
        self.y = self.superview.height - self.height - bottom;
    }
}

- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.width = self.x - left + self.superview.width;
    }
    self.x = left;
}

- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.width = self.superview.width - right - self.x;
    } else {
        self.x = self.superview.width - self.width - right;
    }
}

- (void)topRatioInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    CGFloat topRatio = top / screenType;
    CGFloat topValue = topRatio * self.superview.width;
    [self topInContainer:topValue shouldResize:shouldResize];
}

- (void)bottomRatioInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    CGFloat bottomRatio = bottom / screenType;
    CGFloat bottomValue = bottomRatio * self.superview.width;
    [self bottomInContainer:bottomValue shouldResize:shouldResize];
}

- (void)leftRatioInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    CGFloat leftRatio = left / screenType;
    CGFloat leftValue = leftRatio * self.superview.width;
    [self leftInContainer:leftValue shouldResize:shouldResize];
}

- (void)rightRatioInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    CGFloat rightRatio = right / screenType;
    CGFloat rightValue = rightRatio * self.superview.width;
    [self rightInContainer:rightValue shouldResize:shouldResize];
}

- (void)topEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y;
}

- (void)bottomEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y + view.height - self.height;
}

- (void)leftEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x;
}

- (void)rightEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x + view.width - self.width;
}

- (void)setSize:(CGSize)size screenType:(UIScreenType)screenType
{
    CGFloat ratio = kScreenWidth() / screenType;
    self.frame = CGRectMake(self.x, self.y, size.width * ratio, size.height * ratio);
}

- (void)sizeEqualToView:(UIView *)view
{
    self.frame = CGRectMake(self.x, self.y, view.width, view.height);
}

// imbueset
- (void)fillWidth
{
    self.width = self.superview.width;
    [self centerXEqualToView:self.superview];
}

- (void)fillHeight
{
    self.height = self.superview.height;
    [self centerYEqualToView:self.superview];
}

- (void)fill
{
    self.frame = CGRectMake(0, 0, self.superview.width, self.superview.height);
}

@end
