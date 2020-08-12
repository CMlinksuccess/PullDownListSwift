//
//  SelectListButton.swift
//  PullDownListSwiftDemo
//
//  Created by iMAC on 2020/8/7.
//  Copyright © 2020 xwj. All rights reserved.
//

import UIKit

/// 视图弹出方向
public enum ShowDirectionType {
    case top
    case center
    case bottom
}

private let screenWidth = UIScreen.main.bounds.width
private let screenHeight = UIScreen.main.bounds.height
public typealias SelectItemBlock = (Int,String) -> Void
public class SelectListButton: UIButton {
    //弹框方向
    public var showType: ShowDirectionType = .bottom
    //点击选项回调
    public var selectBlock:SelectItemBlock?
    //选中的选项
    public var selectIndex:Int = 0
    //固定视图高度
    public var selectViewHeight:CGFloat = 0
    //是否显示选择图标
    public var isShowIcon:Bool = false
    //选项高度
    public var itemHeight:CGFloat = 44.0
    //是否弹出视图
    public var isShowSelectView:Bool = true
    //视图的边框颜色
    public var iBorderColor:UIColor?
    //视图的边框大小
    public var iBorderWidth:CGFloat = 0
    //视图的圆角大小
    public var iCornerRadius:CGFloat = 0
    //是否显示分割线
    public var isShowline:Bool = true
    //分割线的颜色
    public var itemLineColor:UIColor?
    //是否显示滑动条
    public var isShowIndicator:Bool = true
    //选中项背景色
    public var itemBgColor:UIColor?
    //选项的文字大小
    public var iTextFont:UIFont?
    //选项的文字颜色
    public var iTextColor:UIColor?
    //选择项的背景色
    public var selectItemBgColor:UIColor?
    
    private var selectItems:[String] = []
    private var isShow:Bool = false
    private var bottomView: UIView?
    private var bgView: UIView?
    private var tableView: UITableView?
    private var buttonFrame: CGRect?
    private static let cellId = "selectListCellId"
    public convenience init(items:[String]) {
        self.init()
        
       showSelectView(items: items)
    }
    ///创建显示视图
    public func showSelectView(items:[String]) {
        selectItems = items
        if selectIndex < items.count {
            setTitle(items[selectIndex], for: .normal)
        }
        addTarget(self, action: #selector(selectClick), for: .touchUpInside)
    }

    ///创建视图
    private func createSelectView() {
        if bgView == nil && isShowSelectView {
            guard let window = UIApplication.shared.delegate?.window as? UIWindow else { return }
            
            bottomView = UIView(frame: window.bounds)
            window.addSubview(bottomView!)
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(deleteItemView))
            tapGes.delegate = self
            bottomView?.addGestureRecognizer(tapGes)
            
            //获取输入框相对窗口的坐标
            guard let textFieldRect = superview?.convert(frame, to: window) else { return }
            buttonFrame = textFieldRect
            //视图Y坐标
            var bgViewY:CGFloat = 0
            let rowHeight = itemHeight 
            if showType == .top {
                if textFieldRect.origin.y - CGFloat(20) > CGFloat(selectItems.count) * rowHeight {
                    bgViewY = textFieldRect.origin.y - CGFloat(selectIndex) * rowHeight
                }else{
                    bgViewY = 20
                }
            }else if showType == .center {
                if textFieldRect.origin.y - CGFloat(20) > CGFloat(selectIndex) * rowHeight {
                    bgViewY = textFieldRect.origin.y - CGFloat(selectIndex) * rowHeight
                }else{
                    bgViewY = 20
                }
            }else{
                bgViewY = textFieldRect.origin.y + textFieldRect.size.height
            }
            ///判断显示屏幕高度内
            var showHeight:CGFloat = 0
            if showType == .top {
                showHeight = textFieldRect.origin.y - bgViewY
            }else{
                if CGFloat(selectItems.count) * rowHeight < screenHeight - bgViewY - 20 {
                    showHeight = CGFloat(selectItems.count) * rowHeight
                }else{
                    showHeight = screenHeight - bgViewY - 20
                }
            }
            if selectViewHeight > 0 {
                showHeight = selectViewHeight
            }
            if showType == .bottom{
                bgView = UIView(frame: CGRect(x: textFieldRect.origin.x, y: bgViewY, width: textFieldRect.size.width, height: 0))
            }else{
                bgView = UIView(frame: CGRect(x: textFieldRect.origin.x, y: textFieldRect.origin.y, width: textFieldRect.size.width, height: 0))
            }
            bgView?.backgroundColor = .white
            bottomView?.addSubview(bgView!)
            
            tableView = UITableView(frame: CGRect(x: 0, y: 0, width: textFieldRect.size.width, height: showHeight), style: .plain)
            tableView?.delegate = self
            tableView?.dataSource = self
            //圆角设置
            if iCornerRadius > 0 {
                bgView?.layer.cornerRadius = iCornerRadius
                bgView?.layer.masksToBounds = true
            }
            //边框设置
            bgView?.layer.borderWidth = iBorderWidth
            if let borderColor = iBorderColor {
                bgView?.layer.borderColor = borderColor.cgColor
            }
            //分割线设置
            if !isShowline {
                tableView?.separatorStyle = .none
            }else if itemLineColor != nil {
                tableView?.separatorColor = itemLineColor
            }
            //是否显示滚动
            tableView?.showsVerticalScrollIndicator = isShowIndicator
            bgView?.addSubview(tableView!)
            
            if let itemColor = itemBgColor {
                bgView?.backgroundColor = itemColor
                tableView?.backgroundColor = itemColor
            }
            
            UIView.animate(withDuration: 0.25) {
                
                self.bgView?.frame = CGRect(x: textFieldRect.origin.x, y: bgViewY, width: textFieldRect.size.width, height: showHeight)
            }
        }
        isShow = true
    }
    ///选择选项
    @objc private func selectClick() {
        if isShow {
            deleteItemView()
        }else{
            createSelectView()
        }
    }
    ///移除视图
    @objc public func deleteItemView() {
        UIView.animate(withDuration: 0.25, animations: {

            if let btnf = self.buttonFrame {
                
                switch self.showType {
                    case .top: self.bgView?.frame.origin.y =  btnf.origin.y
                    case .center:self.bgView?.frame.origin.y =  btnf.origin.y + btnf.size.height/2.0
                    default:break
                }
            }
            self.bgView?.frame.size.height = 0
        }) { [unowned self](finished) in
            self.isShow = false
            self.bottomView?.removeFromSuperview()
            self.bgView?.removeFromSuperview()
            self.tableView?.removeFromSuperview()
            self.bottomView = nil
            self.bgView = nil
            self.tableView = nil
        }
    }
}


extension SelectListButton: UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectItems.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: SelectListButton.cellId)
        if  cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: SelectListButton.cellId)
            cell?.backgroundColor = .clear
            if let textFont = iTextFont {
                cell?.textLabel?.font = textFont
            }
            if let textColor = iTextColor {
                cell?.textLabel?.textColor = textColor
            }
            if isShowIcon {
                
                cell?.imageView?.image = getBundleImage(name: "selected_icon")//UIImage(named: "pullDownListSwift.bundle/selected_icon")
            }
        }
        cell?.textLabel?.text = selectItems[indexPath.row]
        if let selectColor = selectItemBgColor {
            let selectView = UIView(frame: cell!.frame)
            selectView.backgroundColor = selectColor
            cell?.selectedBackgroundView = selectView
        }
        if indexPath.row == selectIndex {
            cell?.imageView?.isHidden = false
        }else{
            cell?.imageView?.isHidden = true
        }
        
        return cell!
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndex = indexPath.row
        self.setTitle(selectItems[indexPath.row], for: .normal)
        
        if let sel = selectBlock {
            sel(indexPath.row,selectItems[indexPath.row])
        }
        deleteItemView()
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {

        if touch.view?.superview?.classForCoder == UITableViewCell().classForCoder  ||  touch.view?.superview?.classForCoder == UITableView().classForCoder{
            return false
        }
        return true
    }
    public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


func getBundleImage(name:String) -> UIImage? {
    let bundlePath = Bundle.main.path(forResource: "./pullDownListSwift", ofType: "bundle")
    let bundle = Bundle(path: bundlePath!)
    let imageStr = bundle?.path(forResource: name, ofType: "png")
    return UIImage(named: imageStr ?? "")
}
