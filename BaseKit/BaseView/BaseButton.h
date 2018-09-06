//
//  BaseButton.h
//
//  Created by 侯佩岑 on 2018/4/24.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HighlightedBlock)(BOOL ishighlighted);

@interface BaseButton : UIButton

@property (nonatomic, copy) HighlightedBlock highlightedBlock;

@end
