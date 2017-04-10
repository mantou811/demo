//
//  StarView.h
//  EvaluationStar
//
//  Created by 赵贺 on 15/11/26.
//  Copyright © 2015年 赵贺. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    MTStarShowTypeLeftShowEmptyImage, //默认显示不选中时的星星
    MTStarShowTypeNoneToLeft,//不显示不选中的星星，并且左对齐；设置setStarBycount这个方法，才起作用
    MTStarShowTypeNoneToRight, //不显示不选中的星星，并且右对齐；设置setStarBycount这个方法，才起作用
} MTStarShowType;


typedef void(^ getStarCountBlock)(NSInteger count);

@interface StarView : UIView
//星星的显示样式
@property (nonatomic, assign) MTStarShowType starShowType;
//通过Block回调获得starCounts
@property (nonatomic,copy) getStarCountBlock getStarCountBlock;
//通过属性获得starCounts
@property(nonatomic,assign,readonly) NSInteger starCounts;
//margin两个星之间的间距
- (id)initWithFrame:(CGRect)frame emptyImage:(NSString *)emptyImage starImage:(NSString *)starImage margin:(CGFloat)margin;
//重新设置显示的星数，调用这个方法后点击不在起作用
- (void)setStarBycount:(int)count;
@end
