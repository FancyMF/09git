//
//  RandomCodeView.h
//  YTZL
//
//  Created by 侯佩岑 on 2018/3/30.
//  Copyright © 2018年 wzt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RandomCodeViewDelegate <NSObject>

-(void)RandomViewDelegateChangeCode;

@end

@interface RandomCodeView : UIView

@property (nonatomic, strong) NSArray *changeArray;
@property (nonatomic, strong) NSMutableString *changeString;

@property (nonatomic, weak) id<RandomCodeViewDelegate> delegate;

-(void)changeCode;
-(BOOL)verfyCode:(NSString *)code;

@end
