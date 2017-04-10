//
//  StarView.m
//  EvaluationStar
//
//  Created by 赵贺 on 15/11/26.
//  Copyright © 2015年 赵贺. All rights reserved.
//

#import "StarView.h"

#define imageW  self.bounds.size.height
#define starCount 5

@interface StarView ()

@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;
@property (assign , nonatomic) CGFloat margin;
@property (assign , nonatomic) NSInteger counts;

@end
@implementation StarView


- (id)initWithFrame:(CGRect)frame emptyImage:(NSString *)emptyImage starImage:(NSString *)starImage margin:(CGFloat)margin{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.height*starCount + (starCount-1)*margin, self.frame.size.height);
        _margin = margin;
        self.starBackgroundView = [self buidlStarViewWithImageName:emptyImage];
        self.starForegroundView = [self buidlStarViewWithImageName:starImage];
        self.starForegroundView.bounds = CGRectMake(0, 0, 0, self.starForegroundView.bounds.size.height);
        [self addSubview:self.starForegroundView];
        [self addSubview:self.starBackgroundView];
        [self bringSubviewToFront:self.starForegroundView];
        self.userInteractionEnabled = YES;
        /**点击手势*/
        UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
        [self addGestureRecognizer:tapGR];
        
        /**滑动手势*/
        
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
        [self addGestureRecognizer:panGR];
    }
    return self;
    
}

- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int j = 0; j < starCount; j ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(j*(imageW + _margin), 0, imageW, imageW);
        [view addSubview:imageView];
    }
    return view;
}

-(void)tapGR:(UITapGestureRecognizer *)tapGR{
    CGPoint point =[tapGR locationInView:self];
    if (point.x<0) {
        point.x = 0;
    }
    int X = (int) point.x/(imageW + _margin);
    _counts = X+1;
    if (_counts >= starCount) {
        _counts = starCount;
    }
    self.starForegroundView.frame = CGRectMake(0, 0, _counts*(imageW + _margin), imageW);
    if (self.getStarCountBlock) {
          self.getStarCountBlock(_counts);
    }
}

- (void)setStarBycount:(int)count
{
    _counts = count;
    if (_starShowType == MTStarShowTypeLeftShowEmptyImage) {
        self.starForegroundView.frame = CGRectMake(0, 0, count*(imageW + _margin), imageW);
        self.starBackgroundView.frame = CGRectMake(0, 0, starCount*(imageW + _margin), imageW);
    }else if (_starShowType == MTStarShowTypeNoneToLeft){
        self.starForegroundView.frame = CGRectMake(0, 0, (count)*(imageW + _margin), imageW);
        self.starBackgroundView.frame = self.starForegroundView.frame;
    }else if (_starShowType == MTStarShowTypeNoneToRight){
        self.starForegroundView.frame = CGRectMake((5-count)*(imageW + _margin), 0, (count)*(imageW + _margin), imageW);
        self.starBackgroundView.frame = self.starForegroundView.frame;
    }
    if (self.getStarCountBlock) {
        self.getStarCountBlock((count));
    }
    self.userInteractionEnabled = NO;
}

- (void)setStarShowType:(MTStarShowType)starShowType
{
    _starShowType = starShowType;
}

-(NSInteger)starCounts
{
    return _counts;
}
@end
