# PullDownListSwift
按钮、输入框可选择列表弹框、输入框右边图片按钮添加的控件封装

## 效果图:  

<img src="https://github.com/CMlinksuccess/PullDownListSwift/blob/master/EffectDrawing/image1.PNG" width="250" height="500" alt="效果图1"><img src="https://github.com/CMlinksuccess/PullDownListSwift/blob/master/EffectDrawing/image3.PNG" width="250" height="450" alt="效果图3"><img src="https://github.com/CMlinksuccess/PullDownListSwift/blob/master/EffectDrawing/image4.PNG" width="250" height="450" alt="效果图4"><img src="https://github.com/CMlinksuccess/PullDownListSwift/blob/master/EffectDrawing/image2.PNG" width="250" height="450" alt="效果图2">

## CocoaPods使用
 在Podfile文件中添加：
```
pod 'PullDownListSwift', '~> 1.0.2'
```
然后，执行下面命令：
```
$ pod install
```
## 使用方法

# 点击按钮弹出选择列表
SelectListButton是继承与UIButton的封装，弹框时只需调用列表方法添加数据即可，调用内部属性设置相应的弹框样式。
```swift
let selectButton = SelectListButton()
 //弹框列表属性设置
        selectButton.showSelectView(items: ["选项1","选项2","选项3","选项4","选项5","选项6","选项7","选项8","选项9","选项10","选项11","选项12","选项13","选项14","选项15","选项16","选项17","选项18","选项19","选项20"])
        selectButton.showType = .bottom
        selectButton.iCornerRadius = 10
        selectButton.iBorderWidth = 1
        selectButton.iTextColor = .gray
        selectButton.iBorderColor = .gray
        selectButton.isShowIcon = true
        selectButton.selectBlock = { (index, text) in
            print("选择后续操作")
        }

```
