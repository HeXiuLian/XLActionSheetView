//
//  HKActionSheetView.m
//  HouseKeeper
//
//  Created by HeXiuLian on 2019/2/13.
//  Copyright © 2019 HeXiuLian. All rights reserved.
//

#import "XLActionSheetView.h"
#import "Masonry.h"
#define XLColorFromHexValueAlpha(s,a)          [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:a]

#define kCancleTextColor  XLColorFromHexValueAlpha(0x666666,1)
#define kSelectItemTextColor  XLColorFromHexValueAlpha(0x333333,1)

@interface XLActionSheetView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic, strong) NSArray  *arrDatas;

@property (nonatomic, copy) NSString * infoKey;

@property (nonatomic, copy) NSString * tipKey;

@property (nonatomic, strong) UIColor  *cancleTextColor;

@property (nonatomic, strong) UIColor  *selectItemColor;

@property (nonatomic, copy) XLActionSheetViewBlock  handleBlock;

@end

@implementation XLActionSheetView

/**
 显示ActionSheet弹窗
 
 @param array 数据数组
 @param infoKey 显示的key  nil :array的对象是字符串， 非空 :array的对象是个字典(包含infoKey)，
 @param tipKey 提示的key  nil :array的对象是字符串， 非空 :array的对象是个字典(包含tipKey)，
 @param cancleTextColor  :取消按钮的颜色： nil默认：0x666666
 @param selectItemTextColor :选项文本的颜色 ：nil默认：0x 333333
 @param handler 回调选择的对象
 */
+ (void)showActionSheetViewWithData:(NSArray *)array
                        showInfoKey:(nullable NSString *)infoKey
                         showTipKey:(nullable NSString *)tipKey
                    cancleTextColor:(nullable UIColor *)cancleTextColor
                selectItemTextColor:(nullable UIColor *)selectItemTextColor
                        backHandler:(XLActionSheetViewBlock)handler {
    
    XLActionSheetView *view = [[XLActionSheetView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = XLColorFromHexValueAlpha(0x000000, 0.4);
    view.arrDatas = array;
    view.infoKey = infoKey;
    view.tipKey = tipKey;
    view.selectItemColor = selectItemTextColor ? selectItemTextColor : kSelectItemTextColor;
    view.cancleTextColor = cancleTextColor ? cancleTextColor :kCancleTextColor;
    view.handleBlock = handler;
    [view setupSubview];
    [view show];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.arrDatas.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UILabel *lblInfo = [[UILabel alloc] init];
        lblInfo.tag = 1234;
        lblInfo.textAlignment = NSTextAlignmentCenter;
        lblInfo.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:lblInfo];
        [lblInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell.contentView);
        }];
        UILabel *lblTip = [[UILabel alloc] init];
        lblTip.tag = 1235;
        lblTip.font = [UIFont systemFontOfSize:10];
        lblTip.textColor = XLColorFromHexValueAlpha(0x999999,1);
        [cell.contentView addSubview:lblTip];
        [lblTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.left.equalTo(lblInfo.mas_right).offset(3);
        }];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 49.3, self.frame.size.width, 0.7)];
        line.backgroundColor = XLColorFromHexValueAlpha(0xdddddd,1);
        [cell.contentView addSubview:line];
    }
    
    UILabel *lblInfo = [cell.contentView viewWithTag:1234];
    UILabel *lblTip = [cell.contentView viewWithTag:1235];
    
    if (indexPath.section == 0) {
        lblInfo.textColor = self.selectItemColor;
        lblInfo.text = self.infoKey ? self.arrDatas[indexPath.row][self.infoKey] : self.arrDatas[indexPath.row];
        lblTip.text = self.tipKey ? self.arrDatas[indexPath.row][self.tipKey] : @"";
    } else {
        lblInfo.text = @"取消";
        lblTip.text = @"";
        lblInfo.textColor = self.cancleTextColor;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        !self.handleBlock ?:self.handleBlock(self.arrDatas[indexPath.row], indexPath.row);
    }
    [self dismiss];
}


- (void)setupSubview {
 
    CGFloat rowHeightH = 50.0;
    CGFloat tableViewHeight = rowHeightH * self.arrDatas.count + rowHeightH + 10;
    
    if (tableViewHeight > self.frame.size.height - 100) {
        tableViewHeight = self.frame.size.height - 100;
    }
    
    CGFloat spaceBottom = [UIScreen mainScreen].bounds.size.height >= 812.0 ? 20 : 0;
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(tableViewHeight);
        make.bottom.mas_equalTo(-spaceBottom);
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.rowHeight = 50.0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.alwaysBounceVertical = NO;
    }
    return _tableView;
}


- (void)dismiss {
    [self removeFromSuperview];
}

- (void)show {
     [[UIApplication sharedApplication].keyWindow addSubview:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
