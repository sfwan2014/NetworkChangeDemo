//
//  PopMenuView.m
//  NetworkChangeDemo
//
//  Created by DBC on 16/8/8.
//  Copyright © kTopBarHeight16年 DBC. All rights reserved.
//

#import "PopMenuView.h"
#import "PopMenuViewController.h"

#define kTopBarHeight   20.0

@implementation PopMenuView{
    CGFloat _screenWidth;
    CGFloat _screenHeight;
    
    BOOL _touchMoving;
    
    UIColor *_normalColor;
    UIColor *_highLightColor;
}

+(PopMenuView *)shareView{
    static PopMenuView *instance = nil;
    if (instance == nil) {
        @synchronized (self) {
            instance = [[[NSBundle mainBundle] loadNibNamed:@"PopMenuView" owner:nil options:nil] lastObject];
        }
    }
    return instance;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
        _screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        _normalColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _highLightColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.backgroundColor = _normalColor;
        
        CGFloat width = 30;
        self.frame = CGRectMake(0, 100, width, width);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = width/2.0;
        self.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor;
        self.layer.borderWidth = 0.5;
    }
    return self;
}

-(void)showCallback:(PopHandleBlock)block{
    [self hide];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    _block = block;
}

-(void)hide{
    if (self.superview) {
        [self removeFromSuperview];
    }
}

- (IBAction)buttonAction:(id)sender {
    if (self.block) {
        self.block();
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self.superview];
    if (p.x <= self.frame.size.width/2.0) {
        p = CGPointMake(self.frame.size.width/2.0, p.y);
    }
    if (p.x >= (_screenWidth - self.frame.size.width/2.0)) {
        p = CGPointMake(_screenWidth - self.frame.size.width/2.0, p.y);
    }
    
    if (p.y <= self.frame.size.height/2.0+kTopBarHeight) {
        p = CGPointMake(p.x, self.frame.size.height/2.0+kTopBarHeight);
    }
    if (p.y >= (_screenHeight - self.frame.size.height/2.0)) {
        p = CGPointMake(p.x, _screenHeight - self.frame.size.height/2.0);
    }
    
    self.center = p;
    
    _touchMoving = YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.backgroundColor = _highLightColor;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_touchMoving) {
        // 触发点击
        NSLog(@"点击了");
        [self buttonAction:nil];
    } else {
        CGPoint p = self.center;
        if (p.x <= _screenWidth/2.0) { // 距左近
            if (p.y <= _screenHeight/2.0) { // 偏上
                if (p.x< p.y-kTopBarHeight) { // 居左边近
                    p = CGPointMake(self.frame.size.width/2.0, p.y);
                } else { // 居上边近
                    p = CGPointMake(p.x, self.frame.size.height/2.0+kTopBarHeight);
                }
            } else { // 偏下
                if (p.x< _screenHeight - p.y) {// 居左边近
                    p = CGPointMake(self.frame.size.width/2.0, p.y);
                } else {// 居下边近
                    p = CGPointMake(p.x, _screenHeight-self.frame.size.height/2.0);
                }
            }
        } else { // 居右
            if (p.y <= _screenHeight/2.0) { // 偏上
                if (_screenWidth-p.x< p.y-kTopBarHeight) {// 居右边近
                    p = CGPointMake(_screenWidth-self.frame.size.width/2.0, p.y);
                } else {// 居上边近
                    p = CGPointMake(p.x, self.frame.size.height/2.0+kTopBarHeight);
                }
            } else { // 偏下
                if (_screenWidth-p.x< _screenHeight - p.y) {//居右边近
                    p = CGPointMake(_screenWidth-self.frame.size.width/2.0, p.y);
                } else {// 居下边近
                    p = CGPointMake(p.x, _screenHeight-self.frame.size.height/2.0);
                }
            }
        }
        
        [UIView animateWithDuration:0.35 animations:^{
            self.center = p;
        } completion:^(BOOL finished) {
            
        }];
    }
    _touchMoving = NO;
    
    self.backgroundColor = _normalColor;
}

@end
