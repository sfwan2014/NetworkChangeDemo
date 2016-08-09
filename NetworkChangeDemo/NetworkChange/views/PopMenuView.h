//
//  PopMenuView.h
//  NetworkChangeDemo
//
//  Created by DBC on 16/8/8.
//  Copyright © 2016年 DBC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PopHandleBlock)(void);

@interface PopMenuView : UIView
@property (nonatomic, copy) PopHandleBlock block;
+(PopMenuView *)shareView;
-(void)showCallback:(PopHandleBlock)block;
@end
