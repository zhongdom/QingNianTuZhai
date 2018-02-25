# 青年图摘
**青年图摘**，实现了大部分*不需要登录*的功能

使用swift4.0重写，自己用了版本月，后来API被关掉用不了了。但是这个项目包含完整的代码，代码完全可以在新项目复用。项目关键点都有注释

用到部分框架：

```
use_frameworks!
inhibit_all_warnings!

# Networking
pod 'Alamofire'
pod 'Kingfisher'
pod 'Alamofire-SwiftyJSON'
pod 'Moya'


# UI
pod 'SnapKit'
pod 'UIView+Positioning'
pod 'IQKeyboardManagerSwift'
pod 'PullToRefreshKit'
pod 'PKHUD' # loading
pod 'SwiftMessages' # 文字提示
pod 'SKPhotoBrowser' # 图片浏览器
pod 'GrowingTextView' # 自动改变大小TextView
pod 'FSPagerView' #  Banner View、Product Show、Welcome/Guide Pages、Screen/ViewController Sliders
  
pod 'JZNavigationExtension' # 右滑返回，改变导航栏状态
pod 'KVOController'
 
pod 'Device'
  
#  pod 'GRDB.swift'
pod 'WCDB.swift'
```



- ~~用swift2.1实现~~
- 使用Cocoapod管理第三方库
- 支持iPad、iPhone，支持横、竖屏
- ~~使用WKWebView，实现缓存功能（UIWebView存在内容泄漏问题，WKWebView解决了这个问题）~~

