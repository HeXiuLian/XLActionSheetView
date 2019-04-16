# XLActionSheet

[![CI Status](https://img.shields.io/travis/815009254@qq.com/XLActionSheet.svg?style=flat)](https://travis-ci.org/815009254@qq.com/XLActionSheet)
[![Version](https://img.shields.io/cocoapods/v/XLActionSheet.svg?style=flat)](https://cocoapods.org/pods/XLActionSheet)
[![License](https://img.shields.io/cocoapods/l/XLActionSheet.svg?style=flat)](https://cocoapods.org/pods/XLActionSheet)
[![Platform](https://img.shields.io/cocoapods/p/XLActionSheet.svg?style=flat)](https://cocoapods.org/pods/XLActionSheet)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

XLActionSheet is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XLActionSheet'
```
## USAGE

#import <XLActionSheet/XLActionSheetView.h>

示例：

[XLActionSheetView showActionSheetViewWithData:@[@"相机",@"相册"] showInfoKey:nil showTipKey:nil cancleTextColor:nil selectItemTextColor:nil backHandler:^(id  _Nonnull result, NSInteger selectIndex) {
NSLog(@"%@---%ld",result,(long)selectIndex);
}];


## Author

815009254@qq.com, xiulian.he@gmail.com

## License

XLActionSheet is available under the MIT license. See the LICENSE file for more info.
