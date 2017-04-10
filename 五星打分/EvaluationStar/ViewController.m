//
//  ViewController.m
//  EvaluationStar
//
//  Created by 赵贺 on 15/11/26.
//  Copyright © 2015年 赵贺. All rights reserved.
//

#import "ViewController.h"
#import "StarView.h"

@interface ViewController ()
@property (strong , nonatomic) StarView *starView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     1、只需要传入frame（最重要的是宽度）及图片就好
     2、如果是多行，则修改y值
     3、默认是五颗星，宽高相等
     
     */
    StarView *starView = [[StarView alloc] initWithFrame:CGRectMake(100, 100, 200, 50) emptyImage:@"emptyStar" starImage:@"Star" margin:20];
    
    StarView *starView1 = [[StarView alloc] initWithFrame:CGRectMake(100, 180, 200, 50) emptyImage:@"emptyStar" starImage:@"Star" margin:20];
    StarView *starView2 = [[StarView alloc] initWithFrame:CGRectMake(100, 260, 200, 50) emptyImage:@"emptyStar" starImage:@"Star" margin:20];
    
    [self.view addSubview:starView];
    [self.view addSubview:starView1];
    [self.view addSubview:starView2];
    
    
    __weak typeof(self) weak_self = self;
    _starView = [[StarView alloc] initWithFrame:CGRectMake(100, 380, 150, 50) emptyImage:@"emptyStar" starImage:@"Star" margin:10];
    _starView.backgroundColor = [UIColor redColor];
    _starView.starShowType = MTStarShowTypeNoneToRight;
    _starView.getStarCountBlock = ^(NSInteger count){
        NSLog(@"%ld",(long)count);
    };
    [self.view addSubview:_starView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_starView setStarBycount:3];
}

@end
