//
//  HKActionSheetView.h
//  HouseKeeper
//
//  Created by HeXiuLian on 2019/2/13.
//  Copyright © 2019 HeXiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^XLActionSheetViewBlock)(id result, NSInteger selectIndex);

@interface XLActionSheetView : UIView

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
                        backHandler:(XLActionSheetViewBlock)handler;




@end

NS_ASSUME_NONNULL_END
