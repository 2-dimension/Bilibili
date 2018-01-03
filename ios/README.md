[![Support](https://img.shields.io/badge/support-iOS_9.0+-green.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![XCode](https://img.shields.io/badge/Xcode-v9.0_beta-6699FF.svg?style=flat)](https://developer.apple.com/xcode/)&nbsp;
[![Swift](https://img.shields.io/badge/swift-4.0-orange.svg?style=flat)](https://swift.org/)&nbsp;
[![CocoaPods](https://img.shields.io/badge/pod-v1.2.1-red.svg?style=flat)](https://cocoapods.org/)&nbsp;

## Project Structure

```
├── App 	Application相关(e.g. AppDelegate)
├── Component	组件
│   ├── Controller	通用Controller
│   └── View	通用View
├── Misc	其他，为了解决了不知道放哪的问题而存在的目录
│   ├── Constants	硬编码常量
│   ├── Extension	扩展
│   └── Storage	数据本地化
├── Module	模块，一般是无耦合可复用的独立组件
│   ├── Account	账号模块
│   ├── Emoticon	表情模块
│   └── Theme	主题模块
├── Supporting Files 	系统文件及脚本生成文件目录
│   └── Base.lproj 	国际化文件
└── iPhone	iPhone客户端的业务逻辑代码
    ├── Attention	动态
    ├── Category	分区
    ├── Discover	发现
    ├── Home		首页
    ├── Others	其他
    └── Profile		我的
```

## Open Source Components

 - [RxSwift](https://github.com/ReactiveX/RxSwift) Reactive programming.
 - [R.swift](https://github.com/mac-cain13/R.swift) Resources managment.
 - [SnapKit](https://github.com/SnapKit/SnapKit) Masonry in Swift.
 - [Kingfisher](https://github.com/onevcat/Kingfisher) Web Image.
 - [SwiftyUserDefaults](https://github.com/mac-cain13/R.swift) NSUserDefaults swift封装
 - [GPUImage2](https://github.com/BradLarson/GPUImage2) 图像处理
 - [SQLite.swift](https://github.com/stephencelis/SQLite.swift) SQLite封装
 - [Spring](https://github.com/MengTo/Spring) 常用动画
 - [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift) 常见加密算法
 - [Hero](https://github.com/lkzhao/Hero)  Elegant transition library
 - [IBAnimatable](https://github.com/IBAnimatable/IBAnimatable) prototype ui
 - [lottie-ios](https://github.com/airbnb/lottie-ios) 在iOS中使用Adobe After Effects vector animation
 - [MJRefresh](https://github.com/CoderMJLee/MJRefresh) 上下拉刷新
 - [WebViewJavascriptBridge](https://github.com/marcuswestin/WebViewJavascriptBridge) JavaScript OC通信

## API Documents

[Postman Documents (temporary)](https://documenter.getpostman.com/collection/view/813452-07b50cee-ea5e-5a39-a42f-b49ad25a83d7)