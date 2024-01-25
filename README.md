# PullDownListSwift
按钮和输入框添加可选择列表弹框、输入框添加右边图片按钮的控件封装

## 效果图:  

<img src="https://github.com/CMlinksuccess/PullDownListSwift/blob/master/EffectDrawing/image1.PNG" width="250" height="500" alt="效果图1"><img src="https://github.com/CMlinksuccess/PullDownListSwift/blob/master/EffectDrawing/image3.PNG" width="250" height="450" alt="效果图2"><img src="https://github.com/CMlinksuccess/PullDownListSwift/blob/master/EffectDrawing/image4.PNG" width="250" height="450" alt="效果图3"><img src="https://github.com/CMlinksuccess/PullDownListSwift/blob/master/EffectDrawing/image2.PNG" width="250" height="450" alt="效果图4">

## CocoaPods使用
 在Podfile文件中添加：
```
pod 'PullDownListSwift'
```
然后，执行下面命令：
```
$ pod install
```
## 使用方法

# 点击UIButton弹出选择列表
SelectListButton是继承与UIButton的封装，弹框时只需调用列表方法添加数据即可，调用内部属性设置相应的弹框样式。
```swift
let selectButton = SelectListButton()
selectButton.frame = CGRect(x: 80, y: 150, width: 250, height: 45)
view.addSubview(selectButton)
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
弹框方向有三种模式：向上、从按钮中心向上下扩展、向下
```swift
/// 视图弹出方向
public enum ShowDirectionType {
    case top
    case center
    case bottom
}
```
视图高度设置,默认高度为给定数组个数计算，也可如下设置固定弹框高度
```swift
selectButton.selectViewHeight = 200
```

# 点击UITextField的右侧按钮弹出选择列表
RightButtonField是继承于UITextField的封装，功能实现右侧添加图片按钮和弹框列表选择。
使用右侧图片方式设置如下：
```swift
let selectTextField = RightButtonField()
view.addSubview(selectTextField)
selectTextField.frame = CGRect(x: 80, y: 300, width: 250, height: 45)
selectTextField.iBorderWidth = 1
selectTextField.iBorderColor = .black
selectTextField.iCornerRadius = 10
selectTextField.iTextColor = .blue
selectTextField.itemHeight = 40
selectTextField.iTextFont = .systemFont(ofSize: 12)
selectTextField.selectViewHeight = 160
selectTextField.createRightView(imageName: "open_show_icon")
selectTextField.placeholder = "请输入昵称"
//按钮回调事件        
selectTextField.rightBtnClick = { [unowned self](isSel) in
   if isSel {
                
       print("按钮选择状态")
   }else{
       print("按钮非选择状态")
   }
}
```
点击右侧图片按钮事件添加列表实现如下：
```swift
var items = ["张三","李四","王五","赵六"]
        
selectTextField.rightBtnClick = { [unowned self](isSel) in
   if isSel {
                
       self.selectTextField.createTableView(data: items)
   }else{
       self.selectTextField.removeTableView()
   }
}
```
删除列表中的选项回调如下：
```swift
selectTextField.itemBlock = { (isDel,index,string) in
    //isDel 为是否删除选项事件，false为选择列表行回调
    if isDel {
        items.remove(at: index)
    }
    print("index:\(index),string:\(string)")
}
```
# 内部资源
pullDownListSwift.bundle

