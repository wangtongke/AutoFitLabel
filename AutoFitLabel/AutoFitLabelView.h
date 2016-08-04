//
//  AutoFitLabelView.h
//  AutoFitLabel
//
//  Created by wtk on 16/2/14.
//  Copyright © 2016年 王同科. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AutoFitLabelView;

typedef void(^WTKBlock)(NSObject *obj);

@interface AutoFitLabelView : UIView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)array;

//存放所有标题
@property(nonatomic,strong)NSArray *array;

@property(nonatomic,copy)WTKBlock block;

- (void)setClickBlock:(WTKBlock)block;


- (void)refresh;
@end
