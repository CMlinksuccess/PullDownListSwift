//
//  ViewController.swift
//  PullDownListSwiftDemo
//
//  Created by iMAC on 2020/8/10.
//  Copyright © 2020 xwj. All rights reserved.
//

import UIKit
import PullDownListSwift

class ViewController: UIViewController {

    private let selectButton = SelectListButton()
    private let rightTextField = RightButtonField()
    private let selectTextField = RightButtonField()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //1.按钮列表
        createButton()
        //2.textfield列表
        createListField()
        //3.textfiled右边按钮
        createTextField()
    }
    
    /// 创建按钮列表
    func createButton() {
        //按钮下拉列表
        view.addSubview(selectButton)
        selectButton.frame = CGRect(x: 80, y: 150, width: 250, height: 45)
        selectButton.layer.cornerRadius = 10
        selectButton.layer.masksToBounds = true
        selectButton.layer.borderWidth = 1
        selectButton.layer.borderColor = UIColor.black.cgColor
        selectButton.setTitle("默认值", for: .normal)//列表数据空时显示
        selectButton.contentHorizontalAlignment = .left
        selectButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        selectButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        selectButton.setTitleColor(.gray, for: .normal)
        selectButton.setImage(UIImage(named: "open_show_icon"), for: .normal)
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
    }
    //创建textField下拉列表
    func createListField() {
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
        var items = ["张三","李四","王五","赵六"]
        
        selectTextField.rightBtnClick = { [unowned self](isSel) in
            if isSel {
                
                self.selectTextField.createTableView(data: items)
            }else{
                self.selectTextField.removeTableView()
            }
        }
        selectTextField.itemBlock = { (isDel,index,string) in
            //isDel 为是否删除选项事件
            if isDel {
                items.remove(at: index)
            }
            print("index:\(index),string:\(string)")
        }
    }
    
    //创建输入框右边按钮
    func createTextField() {
        view.addSubview(rightTextField)
        rightTextField.frame = CGRect(x: 80, y: 450, width: 250, height: 45)
        rightTextField.delegate = self
        rightTextField.createRightView(imageName: "paHidden")
        rightTextField.placeholder = "请输入密码"
        rightTextField.isSecureTextEntry = true
        rightTextField.rightBtnClick = { [unowned self](isSel) in
            if isSel { //选择状态
                self.rightTextField.imageName = "pwShow"
                self.rightTextField.isSecureTextEntry = false
            }else{ //非选择状态
                self.rightTextField.imageName = "paHidden"
                self.rightTextField.isSecureTextEntry = true
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate,UIGestureRecognizerDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == rightTextField {
            rightTextField.transform = CGAffineTransform(translationX: 0, y: -50)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == rightTextField {
            rightTextField.transform = .identity
        }
    }
}
