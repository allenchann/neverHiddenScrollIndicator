//
//  CWLScrollView.m
//  neverHiddenScrollIndicator
//
//  Created by allen_Chan on 2017/6/13.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "CWLScrollView.h"

@interface CWLScrollView ()

{
    BOOL firstAdd;
    UIImageView *verticalIndicator;
    UIImageView *horizontalIndicator;
    CGSize currentSize;
}

/////竖直滚动条
//@property (nonatomic, retain) UIImageView *verticalIndicator;
/////水平滚动条
//@property (nonatomic, retain) UIImageView *horizontalIndicator;

@end

@implementation CWLScrollView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

///是否需要显示滚动条
- (void)showIndicatorOrNotWithSize:(CGSize)size {
    horizontalIndicator = [self valueForKey:@"_horizontalScrollIndicator"];
    verticalIndicator = [self valueForKey:@"_verticalScrollIndicator"];
    if (size.height>self.frame.size.height) {
        [verticalIndicator addObserver:self forKeyPath:@"alpha" options:NSKeyValueObservingOptionNew context:nil];
    }
    if (size.width>self.frame.size.width) {
        [horizontalIndicator addObserver:self forKeyPath:@"alpha" options:NSKeyValueObservingOptionNew context:nil];
    }

}

///响应监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    ///判断是哪个视图响应的监听方法
    if ([object isKindOfClass:[UIImageView class]]) {
        ///获取到滚动条
        UIImageView *scrollIndicator = object;
        if ([change[@"new"] intValue] == 0) {
            scrollIndicator.alpha = 1;
        }
    }else if ([object isKindOfClass:[UIScrollView class]]) {
        ///先显示滚动条,因为滚动条是属于懒加载,此时可能滚动条所在的Imageview尚未初始化
        CGSize size = [change[@"new"] CGSizeValue];
        [self flashScrollIndicators];
        ///判断是否显示滚动条
        [self showIndicatorOrNotWithSize:size];
    }
    
}

///移除监听
- (void)dealloc {
    [verticalIndicator removeObserver:self forKeyPath:@"alpha"];
    [horizontalIndicator removeObserver:self forKeyPath:@"alpha"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!firstAdd) {
        [self flashScrollIndicators];
        [self showIndicatorOrNotWithSize:self.contentSize];
        firstAdd = YES;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
