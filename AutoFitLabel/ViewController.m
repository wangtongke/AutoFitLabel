//
//  ViewController.m
//  AutoFitLabel
//
//  Created by wtk on 16/2/14.
//  Copyright © 2016年 王同科. All rights reserved.
//

#import "ViewController.h"
#import "AutoFitLabelView.h"
#import "MSSAutoresizeLabelFlow.h"

#define WTKScale    [UIScreen mainScreen].bounds.size.width/375.0f
@interface ViewController ()

@property(nonatomic,strong)AutoFitLabelView *firstView;

@property(nonatomic,strong)MSSAutoresizeLabelFlow *secondView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"中国",@"韩国",@"日本",@"越南",@"泰国",@"巴基斯坦",@"叙利亚",@"智利",@"马来西亚",@"卡塔尔",@"菲律宾",@"新加坡",@"伊朗",@"朝鲜"];
    _firstView = [[AutoFitLabelView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)titleArray:array];
    [_firstView setClickBlock:^(NSObject *obj) {
        NSString *string = (NSString *)obj;
        NSLog(@"%@",string);
    }];

    _secondView = [[MSSAutoresizeLabelFlow alloc]initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, 100) titles:array selectedHandler:^(NSUInteger index, NSString *title) {
        NSLog(@"%@",title);
    }];

}
- (IBAction)FirstBtnClick:(id)sender
{


    [self.view addSubview:_firstView];
}
- (IBAction)SecondBtnClick:(id)sender
{

    [self.view addSubview:_secondView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
