//
//  XLViewController.m
//  XLActionSheet
//
//  Created by 815009254@qq.com on 04/16/2019.
//  Copyright (c) 2019 815009254@qq.com. All rights reserved.
//

#import "XLViewController.h"
#import "XLActionSheetView.h"
#import "Masonry.h"

@interface XLViewController ()

@end

@implementation XLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [self getButtonWithTitle:@"样式1" action:@selector(style1)];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(100);
    }];

    UIButton *btn2 = [self getButtonWithTitle:@"样式2" action:@selector(style2)];
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(btn1.mas_bottom).offset(20);
    }];

    UIButton *btn3 = [self getButtonWithTitle:@"样式3" action:@selector(style3)];
    [self.view addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(btn2.mas_bottom).offset(20);
    }];
    
}

- (void)style1 {
    [XLActionSheetView showActionSheetViewWithData:@[@"相机",@"相册"] showInfoKey:nil showTipKey:nil cancleTextColor:nil selectItemTextColor:nil backHandler:^(id  _Nonnull result, NSInteger selectIndex) {
        NSLog(@"%@---%ld",result,(long)selectIndex);
    }];
}

- (void)style2 {
    NSArray *arr = @[@{@"mapName":@"高德地图",@"tip":@""},
                     @{@"mapName":@"百度地图",@"tip":@"未安装"},
                     @{@"mapName":@"苹果地图",@"tip":@""}];
    [XLActionSheetView showActionSheetViewWithData:arr showInfoKey:@"mapName" showTipKey:@"tip" cancleTextColor:[UIColor orangeColor] selectItemTextColor:nil backHandler:^(id  _Nonnull result, NSInteger selectIndex) {
        NSLog(@"%@---%ld",result,(long)selectIndex);
    }];
}

- (void)style3 {
    NSArray *arr = @[@{@"job":@"技术总监",@"id":@"123"},
                     @{@"job":@"JAVA工程师",@"id":@"124"},
                     @{@"job":@"iOS研发工程师",@"id":@"125"}];
    [XLActionSheetView showActionSheetViewWithData:arr showInfoKey:@"job" showTipKey:nil cancleTextColor:nil selectItemTextColor:[UIColor orangeColor] backHandler:^(id  _Nonnull result, NSInteger selectIndex) {
        NSLog(@"%@---%ld",result,(long)selectIndex);
    }];
}


- (UIButton *)getButtonWithTitle:(NSString *)title action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
