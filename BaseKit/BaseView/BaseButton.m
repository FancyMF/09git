//
//  BaseButton.m
//
//  Created by 侯佩岑 on 2018/4/24.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "BaseButton.h"

static NSString * const kButtonHighlighted = @"highlighted";

@implementation BaseButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver:self forKeyPath:kButtonHighlighted options:(NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew) context:(__bridge void * _Nullable)(kButtonHighlighted)];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addObserver:self forKeyPath:kButtonHighlighted options:(NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew) context:(__bridge void * _Nullable)(kButtonHighlighted)];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    BOOL old = [[change valueForKey:NSKeyValueChangeOldKey] boolValue];
    BOOL new = [[change valueForKey:NSKeyValueChangeNewKey] boolValue];
    if (old != new) {
        if (self.highlightedBlock) {
            self.highlightedBlock(new);
        }
    }
}



-(void)dealloc{
    [self removeObserver:self forKeyPath:kButtonHighlighted context:(__bridge void * _Nullable)(kButtonHighlighted)];
}

@end
