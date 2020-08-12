//
//  RightButtonField.swift
//  PullDownListSwiftDemo
//
//  Created by iMAC on 2020/8/7.
//  Copyright © 2020 xwj. All rights reserved.
//

import UIKit

private let screenHeight = UIScreen.main.bounds.height
public typealias TextFieldButtonClick = (Bool) -> Void
public typealias TextItemBlock = (Bool,Int,String) -> Void/*Bool值为是否删除行事件*/
public class RightButtonField: UITextField,UITextFieldDelegate {
    //右边按钮相关
    public var rightBtnClick:TextFieldButtonClick?
    public var imageName:String = ""{
        didSet{
            imageView?.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    public var rightViewW:CGFloat = 45
    public var rightViewH:CGFloat = 40
    
    /*列表相关*/
    //点击选项回调
    public var itemBlock:TextItemBlock?
    //是否显示删除小按钮
    public var showDelete:Bool = true
    //选项高度
    public var itemHeight:CGFloat = 40.0
    //固定视图高度,不设置根据itemHeight计算高度
    public var selectViewHeight:CGFloat = 0
    //选项的文字大小
    public var iTextFont:UIFont?
    //选项的文字颜色
    public var iTextColor:UIColor?
    //选项的背景色
    public var itemBgColor:UIColor?
    //视图的边框颜色
    public var iBorderColor:UIColor?
    //视图的边框大小
    public var iBorderWidth:CGFloat = 0
    //视图的圆角大小
    public var iCornerRadius:CGFloat = 0

    private var imageView:UIButton?
    private var deleteBtn:UIButton!
    private var tableView:UITableView?
    private static let listCellId:String = "listCellId"
    private var lists:[String]?
    
    /// 创建右侧按钮
    /// - Parameter imageName: 右侧按钮图片名
    public func createRightView(imageName:String) {
        createRightView(image: UIImage(named: imageName))
    }
    
    /// 创建右侧按钮
    /// - Parameter image: 右侧按钮图片
    public func createRightView(image:UIImage?) {
        self.addTarget(self, action: #selector(beginEdit), for: .editingDidBegin)
        self.addTarget(self, action: #selector(endEdit), for: .editingDidEnd)
        rightViewMode = .always
        font = .systemFont(ofSize: 15)
        let rightViews = UIView(frame: CGRect(x: 0, y: 0, width: rightViewW, height: rightViewH))
        deleteBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: rightViewH))//UIImage(named: "pullDownListSwift.bundle/textDelete_btn")
        deleteBtn.setImage(Bundle.textDeleteIcon, for: .normal)
        deleteBtn.addTarget(self, action: #selector(deleteClick), for: .touchUpInside)
        deleteBtn.isHidden = true
        imageView = UIButton(frame: CGRect(x: 20, y: 0, width: rightViewW - 20 , height: rightViewH))
        imageView?.addTarget(self, action: #selector(click(button:)), for: .touchUpInside)
        imageView?.setImage(image, for: .normal)
        rightViews.addSubview(deleteBtn)
        rightViews.addSubview(imageView!)
        rightView = rightViews
        
        let line = UIView()
        line.backgroundColor = .black
        self.addSubview(line)
        line.frame = CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: 0.5)
    }
    @objc public func deleteClick(){
        self.text = ""
    }
    @objc func click(button:UIButton) {
        button.isSelected = !button.isSelected
        if let btnClick = rightBtnClick {
            btnClick(button.isSelected)
        }
    }
    @objc func beginEdit() {
        deleteBtn.isHidden = false
    }
    @objc func endEdit() {
        deleteBtn.isHidden = true
    }
    
    /// 创建下拉列表
    /// - Parameter data: 下拉列表数据
    public func createTableView(data:[String]) {
        lists = data
        tableView = UITableView()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = .white
        tableView?.layer.cornerRadius = iCornerRadius
        tableView?.layer.masksToBounds = true
        tableView?.layer.borderWidth = iBorderWidth
        tableView?.layer.borderColor = iBorderColor?.cgColor
        tableView?.register(TextFieldSelectCell.classForCoder(), forCellReuseIdentifier: RightButtonField.listCellId)
        
        if let window = UIApplication.shared.keyWindow{
            
            let fra = self.convert(bounds, to: window)
            tableView?.frame = CGRect(x: fra.origin.x, y: fra.origin.y + fra.size.height + 1, width: fra.size.width, height:0)
            window.addSubview(tableView!)
            var tableViewH:CGFloat = (selectViewHeight > 0) ? selectViewHeight : CGFloat(self.lists?.count ?? 0) * itemHeight
            if tableViewH > screenHeight - frame.origin.y - frame.size.height  {
                tableViewH = screenHeight - frame.origin.y - frame.size.height
            }
            UIView.animate(withDuration: 0.25) {

                self.tableView?.frame.size.height = tableViewH
            }
        }
    }
    //移除列表视图
    public func removeTableView() {

        UIView.animate(withDuration: 0.25, animations: {
            
            self.tableView?.frame.size.height = 0
        }) { (compet) in
            
            self.tableView?.removeFromSuperview()
            self.tableView = nil
        }
    }
}

extension RightButtonField: UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: RightButtonField.listCellId) as? TextFieldSelectCell
        if cell == nil {
            cell = TextFieldSelectCell()
        }
        cell?.title = lists?[indexPath.row] ?? ""
        cell?.showDelete = showDelete
        cell?.iTextFont = iTextFont
        cell?.iTextColor = iTextColor
        cell?.backgroundColor = itemBgColor
        cell?.cellDeleteClick = { [unowned self]() in
            
            let txt = self.lists?.remove(at: indexPath.row)
            self.tableView?.reloadData()
            if let sel = self.itemBlock {
                sel(true,indexPath.row,txt ?? "")
            }
        }
        return cell!
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        text = lists?[indexPath.row]
        click(button: imageView!)
        if let sel = itemBlock {
            sel(false,indexPath.row,text ?? "")
        }
    }
}

