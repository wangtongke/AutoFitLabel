//
//  AutoFitLabelView.m
//  AutoFitLabel
//
//  Created by wtk on 16/2/14.
//  Copyright © 2016年 王同科. All rights reserved.
//

#import "AutoFitLabelView.h"
#define WTKScale    [UIScreen mainScreen].bounds.size.width/375.0f
#define FONT [UIFont systemFontOfSize:15.0]
#define WTKWindowWidth ([[UIScreen mainScreen] bounds].size.width)

@interface AutoFitLabelView ()

///存放btn
@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)NSMutableArray *btnArray;
@property(nonatomic,strong)NSMutableArray *lineArray;
@property(nonatomic,strong)UIButton *lastBtn;

@end

@implementation AutoFitLabelView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.array = array;
        [self addSubview:self.scrollView];
        self.backgroundColor = [UIColor blackColor];
        [self refresh];
    }
    return self;
}


- (void)configView
{
    [self refresh];
}

- (void)refresh
{
//    先移除
    for (UIButton *btn in self.btnArray)
    {
        [btn removeFromSuperview];
    }
    for (UIView *view in self.lineArray)
    {
        [view removeFromSuperview];
    }
    
//    9宫格创建
    /*
     1  懒加载创建btn
     2  设定 超过18个字后 换行 或者是6个按钮 并且每行最少两个
     
     */
    
//    第一个距边界的距离
    CGFloat margin = 10 * WTKScale;
    
//    记录当前是第几行
    int numOfRow = 0;
    for (int i = 0; i < self.array.count; i++)
    {
//        文字总宽度
        CGFloat widthSum = 0;
        
//        字的个数
        int wordNum = 0;
//        btn个数
        int btnNum = 0;
        
        //计算当前行的btn个数
        int j = i;
        while (j < i+ 6)
        {
            if (j < self.array.count)
            {
                NSString *string = self.array[j];
                wordNum += string.length;
                
//                计算文字所需要的总宽度
                widthSum += [self calculateWidthWithString:string];
                if (wordNum >=18 && btnNum > 2)
                {
                    widthSum -=[self calculateWidthWithString:string];
                    break;
                }
                btnNum ++;
                
            }
            j++;
        }
        
//        记录当前的X
        CGFloat currentSum = margin;
        CGFloat columnMargin = (WTKWindowWidth - 2 * margin -widthSum) / (btnNum - 1);
        
//        创建当前行的btn
        for (int index = i; index < i + btnNum; index ++)
        {
            if (columnMargin > 30)
            {
                columnMargin = 30;
            }
            UIButton *btn = nil;
            if (index < self.btnArray.count)
            {
                btn = self.btnArray[index];
            }
            else
            {
                btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [self.btnArray addObject:btn];
            }
            btn.tag = index;
            [btn setTitle:self.array[index] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
            btn.backgroundColor = [UIColor clearColor];
            btn.titleLabel.font = FONT;
            btn.tag = index;
            CGFloat btnWidth = [self calculateWidthWithString:self.array[index]];
            CGFloat btnheight = 20 * WTKScale;
            CGFloat x = currentSum;
            CGFloat y = numOfRow * 40 * WTKScale + 10 * WTKScale;
            btn.frame = CGRectMake(x, y, btnWidth, btnheight);
            [_scrollView addSubview:btn];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
//            创建后面的线
            if (index < i + btnNum - 1)
            {
                UIView *line = nil;
                if (index < self.lineArray.count)
                {
                    line = self.lineArray[index];
                }
                else
                {
                    line = [[UIView alloc]init];
                    [self.lineArray addObject:line];
                }
                line.frame = CGRectMake(x + btnWidth + columnMargin / 2.0 - 0.5, y + 3 + WTKScale, 1, 14 * WTKScale);
                line.backgroundColor = [UIColor whiteColor];
                [self.scrollView addSubview:line];
            }
            currentSum +=(btnWidth + columnMargin);

           
        }
        numOfRow +=1;
        i = j;
    }
    
}

- (void)btnClick:(UIButton *)sender
{
    NSString *string = self.array[sender.tag];
    _block(string);
}

- (void)setClickBlock:(WTKBlock)block
{
    _block = block;
}

///根据文字计算label的长度
- (CGFloat)calculateWidthWithString:(NSString *)string
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT} context:nil];
    CGFloat width = rect.size.width;
    
    return width;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        
    }
    return _scrollView;
}
- (NSMutableArray *)btnArray
{
    if (!_btnArray)
    {
        _btnArray = [[NSMutableArray alloc]init];
    }
    return _btnArray;
}
- (NSMutableArray *)lineArray
{
    if (!_lineArray)
    {
        _lineArray = [[NSMutableArray alloc]init];
    }
    return _lineArray;
}
@end
