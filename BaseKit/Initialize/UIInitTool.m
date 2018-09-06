//
//  UIInitTool.m
//

#import "UIInitTool.h"

@interface UIInitTool()

@end

@implementation UIInitTool

#pragma mark - Uninversal Const
CGFloat kRowHeight(){
    return 55;
}

CGFloat kButtonDefaultHeight(){
    return 44;
}

CGFloat kButtonWithBGViewDefaultHeight(){
    return 60;
}

CGFloat kLineDefaultHeight(){
    return 0.7;
}

CGFloat kSpaceToTop(){
    return 12;
}

CGFloat kSpaceBetween(){
    return 8;
}

CGFloat kSpaceToLeft(){
    return 16;
}




#pragma mark - UIScreen

CGFloat kNormalScreenWidth(){
    return [UIScreen mainScreen].bounds.size.width;
}

CGFloat kNormalScreenHeight(){
    return [UIScreen mainScreen].bounds.size.height;
}

bool isLandscape(){
    return UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]);
}

CGFloat kScreenWidth(){
    return isLandscape() ? kNormalScreenHeight() : kNormalScreenWidth();
}

CGFloat kAllHeight(){
    return isLandscape() ? kNormalScreenWidth() : kNormalScreenHeight();
}



CGFloat kScreenHeight(){
    return kAllHeight() - kStatusBarHeight() - kNavigationHeight;
}

CGFloat kSafeAreaBottomHeight(void){
    if (kNormalScreenHeight() == 812.0) {
        return 20;
    }
    return 0;
}

CGFloat kStatusBarHeight(void){
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

CGFloat kScreenScale(UIScreenType screenType){
    return kScreenWidth()/screenType;
}

#pragma mark - UIColor
UIColor* kColor(int ace_r ,int ace_g ,int ace_b ,float ace_alpha){
    return [UIColor colorWithRed:ace_r/255.0 green:ace_g/255.0 blue:ace_b/255.0 alpha:ace_alpha];
}

UIColor* kColorValue(int rgbValue){
    return [UIColor colorWithRed:((rgbValue >> 16) & 0xFF)/255.f
                           green:((rgbValue >> 8) & 0xFF)/255.f
                            blue:(rgbValue & 0xFF)/255.f
                           alpha:1.0f];
}


UIColor* kColorValueAlpha(int rgbValue,float alphaValue){
    return [UIColor colorWithRed: ((rgbValue >> 16) & 0xFF)/255.f
                           green:((rgbValue >> 8) & 0xFF)/255.f
                            blue:(rgbValue & 0xFF)/255.f
                           alpha:alphaValue];
}

UIColor* kSystemColorWhite(){
    return kColorBackground();
}
UIColor* kColorWhite(){
    return kColorValue(0xffffff);
}
UIColor* kSystemColorBlue(){
    return kColorValue(0x3488c5);
}

UIColor* kColorBackground(void){
    return kColorValue(0xf2f2f2);
}

UIColor* kColorTheme(void){
    return kColor(62, 193, 167, 1);
}

UIColor* kColorUnable(void){
    return kColorValue(0xdbdbdb);
}

UIColor* kColorLine(void){
    return kColorValue(0xe8e8e8);
}

UIColor* kColorBorder(void){
    return kColorValue(0x0068ff);
}

UIColor* kColorError(void){
    return kColorValue(0xd83c3c);
}

UIColor* kColorText(void){
    return kColorValue(0x0068ff);
}

UIColor* kColorTextTheme(void){
    return kColorTheme();
}

UIColor* kColorTextDefault(void){
    return kColorValue(0x353535);
}


UIColor* kColorTextLight(void){
    return kColor(102, 102, 102, 1);
}

UIColor* kColorTextLightGray(void){
    return kColorValue(0x888888);
}

#pragma mark - UIFont

UIFont* kFontSize(float size){
    return [UIFont systemFontOfSize:size];
}

UIFont* kFontBodySize(float size){
    return [UIFont boldSystemFontOfSize:size];
}

UIFont* kFontSysterm20(){
    return [UIFont systemFontOfSize:20.0];
}
UIFont* kFontSysterm16(){
    return [UIFont systemFontOfSize:16.0];
}
UIFont* kFontSysterm14(){
    return [UIFont systemFontOfSize:14.0];
}
UIFont* kFontSysterm12(){
    return [UIFont systemFontOfSize:12.0];
}


UIFont* kFontWithNameAndSize(NSString* name, float size){
    NSString* baseName = @"PingFangSC";
    name = [baseName stringByAppendingFormat:@"-%@",name];
    UIFont* font = [UIFont fontWithName:name size:size];
    if (font == nil) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

UIFont* kFontLight16(){
   return kFontWithNameAndSize(@"Light", 16.0);
}

UIFont* kFontLight14(){
    return kFontWithNameAndSize(@"Light", 14.0);
}

UIFont* kFontLight12(){
    return kFontWithNameAndSize(@"Light", 12.0);
}

UIFont* kFontThin12(){
    return kFontWithNameAndSize(@"Thin", 12.0);
}

#pragma mark - init UI
UIImage * kImageName(NSString * imageName){
    return [UIImage imageNamed:imageName?:@""];
}
NSURL * kURL(NSString * urlString){
    return [NSURL URLWithString:urlString?:@""];
}

#pragma mark - init UI

+ (UIView *)viewWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor toSuperV:(UIView *)superV{
    UIView* view = [[UIView alloc] initWithFrame:frame];
    
    if (backgroundColor) {
        [view setBackgroundColor:backgroundColor];
    }
    
    if (superV) {
        [superV addSubview:view];
    }
    return view;
}

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textAlignMent:(NSTextAlignment)textAlignMent font:(UIFont *)font textColor:(UIColor *)textColor fitSize:(BOOL)fit toSuperV:(UIView *)superV{
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.textAlignment = textAlignMent;
    label.font = font;
    
    if (fit){
        [label sizeToFit];
    }
    
    if (superV) {
        [superV addSubview:label];
    }
    
    return label;
}
+ (UIButton *)rightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action tag:(int)tag{
    UIButton* rightButton = [self buttonWithFrame:CGRectZero title:title font:kFontSize(16.0) textColor:kColorText() tag:tag target:target action:action superView:nil];
    CGFloat width = [title widthWithFont:kFontSysterm16()];
    rightButton.frame = CGRectMake(kScreenWidth() - width - kCornerInset, 20.0, width, 44.0);
    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake((44.0 - 16.0)/2.0, 0, (44.0 - 16.0)/2.0, 0)];
    
    return rightButton;
}

+ (UIButton *)rightItemWithImage:(NSString *)imageName target:(id)target action:(SEL)action tag:(int)tag{
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage* image = [UIImage imageNamed:imageName];
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    if (height > kNavigationHeight) {
        width *= kNavigationHeight/height;
        height = kNavigationHeight;
    }
    
    CGFloat verticalInset = (kNavigationHeight - height)/2.0;
    CGFloat horizenInset = 0;
    CGFloat buttonWidth = width;
    if (width < kNavigationHeight) {
        horizenInset = (kNavigationHeight - width)/2.0;
        buttonWidth = kNavigationHeight;
    }
    
    rightButton.frame = CGRectMake(kScreenWidth() - buttonWidth - kCornerInset, 20.0, buttonWidth, kNavigationHeight);
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(verticalInset, horizenInset, verticalInset, horizenInset)];
    
    return rightButton;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor tag:(NSInteger)tag target:(id)target action:(SEL)action superView:(UIView*)superV{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.tag = tag;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (superV) {
        [superV addSubview:button];
    }
    
    return button;
}

+ (UISegmentedControl*)segmentedControlWithSuperView:(UIView*)superV target:(NSObject*)target action:(SEL)action frame:(CGRect)frame titles:(NSArray*)titles tintColor:(UIColor*)tintColor normalTextColor:(UIColor*)normalColor selectedTextColor:(UIColor*)selectedColor font:(UIFont*)font{
    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems:titles];
    [segmentedControl addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    segmentedControl.frame = frame;
    segmentedControl.tintColor = tintColor;
    
    if (superV) {
        [superV addSubview:segmentedControl];
    }
    
    segmentedControl.momentary = NO;
    
    //设置segment的字体大小和颜色
    NSDictionary *dicNormal = [NSDictionary dictionaryWithObjectsAndKeys:normalColor,NSForegroundColorAttributeName,font,NSForegroundColorAttributeName ,nil];
    NSDictionary *dicSelected = [NSDictionary dictionaryWithObjectsAndKeys:selectedColor,NSForegroundColorAttributeName,font,NSForegroundColorAttributeName ,nil];
    //设置各种状态的字体和颜色
    [segmentedControl setTitleTextAttributes:dicNormal forState:UIControlStateNormal];
    [segmentedControl setTitleTextAttributes:dicSelected forState:UIControlStateSelected];
    
    return segmentedControl;
}

+ (UITableView *)tableViewWithFrame:(CGRect)frame backgroundColor:(UIColor*)backColor style:(UITableViewStyle)style speratorStyle:(UITableViewCellSeparatorStyle)spetatorStyle dataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate superView:(UIView *)superV{
    UITableView* tableV = [[UITableView alloc] initWithFrame:frame style:style];
    tableV.dataSource = dataSource;
    tableV.delegate = delegate;
    tableV.separatorStyle = spetatorStyle;
    tableV.backgroundColor = backColor;
    if (superV) {
        [superV addSubview:tableV];
    }
    return tableV;
}

+ (UITextField*)textFieldWithFrame:(CGRect)frame delegate:(id)delegate font:(UIFont*)font textAlignMent:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor returnType:(UIReturnKeyType)returnKeyType clearMode:(UITextFieldViewMode)clearBtnMode placeHolder:(NSString*)placeHolder superView:(UIView*)superV{
    UITextField* field = [[UITextField alloc]initWithFrame:frame];
    field.delegate = delegate;
    field.textAlignment = textAlignment;
    field.textColor = textColor;
    field.font = font;
    field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    field.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    field.returnKeyType = returnKeyType;
    field.clearButtonMode = clearBtnMode;
    field.placeholder = placeHolder;
    if (superV) {
        [superV addSubview:field];
    }
    return field;
}

+ (UITextView*)textViewWithFrame:(CGRect)frame delegate:(id)delegate borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)radius font:(UIFont*)font textAlignMent:(NSTextAlignment)textAlignment borderColor:(UIColor *)borderColor  textColor:(UIColor *)textColor{
    UITextView *textview = [[UITextView alloc] initWithFrame:frame];
    textview.delegate = delegate;
    textview.font = font;
    textview.textAlignment = textAlignment;
    textview.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textview.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if (!textColor){
        textview.textColor = [UIColor whiteColor];
    }
    else
    {
        textview.textColor = textColor;
    }
    
    if (borderColor && 0.0 != borderWidth){
        textview.layer.borderWidth = borderWidth;
        textview.layer.borderColor = borderColor.CGColor;
    }
    
    if (0.0 != radius){
        textview.layer.cornerRadius = radius;
    }

    return textview;
}

+ (UIProgressView*)ProgressViewWithFrame:(CGRect)frame style:(UIProgressViewStyle)style backColor:(UIColor*)backColor progressColor:(UIColor*)progressColor value:(CGFloat)value{
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:frame];
    progressView.backgroundColor = [UIColor clearColor];
    progressView.progressViewStyle = style;
    progressView.progress = value;
    progressView.progressTintColor = progressColor;
    progressView.trackTintColor = backColor;

    return progressView;
}

+ (UIActivityIndicatorView*)activityIndicatorViewWithFrame:(CGRect)frame backColor:(UIColor*)backColor styleColor:(UIColor*)styleColor style:(UIActivityIndicatorViewStyle)style{
    UIActivityIndicatorView* indicatorV = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    indicatorV.backgroundColor = backColor;
    indicatorV.color = styleColor;
    indicatorV.activityIndicatorViewStyle = style;
    return indicatorV;
}

+ (UISearchBar*)searchBarWithStyle:(UISearchBarStyle)style frame:(CGRect)frame delegate:(id)delegate placeholder:(NSString*)placeholder tintColor:(UIColor*)tintColor barTintColor:(UIColor*)barTintColor backImage:(UIImage*)backImage{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:frame];

    searchBar.delegate = delegate;
    searchBar.placeholder = placeholder;
    searchBar.searchBarStyle = UISearchBarStyleProminent;
    searchBar.tintColor = tintColor;
    searchBar.barTintColor = barTintColor;
    searchBar.backgroundImage = backImage;
    return searchBar;
}

+ (UISegmentedControl*)segmentedControlWithTintColor:(UIColor*)tintColor titles:(NSArray<NSString*> *)titles frame:(CGRect)frame target:(id)target action:(SEL)action selectedIndex:(NSInteger)selectedIndex{
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:titles];
    
    segmentControl.backgroundColor = [UIColor whiteColor];
    segmentControl.frame = frame;
    
    segmentControl.tintColor = tintColor;
    
    segmentControl.selectedSegmentIndex = selectedIndex;
    //    segmentControl.momentary = YES; // 是否保持选中状态
    
    [segmentControl addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    
    return segmentControl;
}

@end
