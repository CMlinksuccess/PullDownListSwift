//
//  TextFileldSelectCell.swift
//  PullDownListSwiftDemo
//
//  Created by iMAC on 2020/8/7.
//  Copyright © 2020 xwj. All rights reserved.
//

import UIKit

typealias CellDeleteClick = () -> Void
class TextFieldSelectCell: UITableViewCell {

    var cellDeleteClick:CellDeleteClick?

    var title:String = ""{
        didSet{
            titleLab.text = title
        }
    }
    var showDelete:Bool = true {
        didSet{
            deleteBtn.isHidden = !showDelete
        }
    }
    var iTextFont:UIFont?{
        didSet{
            titleLab.font = iTextFont
        }
    }
    var iTextColor:UIColor?{
        didSet{
            titleLab.textColor = iTextColor
        }
    }
    
    
    private var titleLab = UILabel()
    private var deleteBtn = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLab.font = .systemFont(ofSize: 15)
        //UIImage(named: "pullDownListSwift.bundle/textDelete_btn")
        deleteBtn.setImage(getBundleImage(name: "textDelete_btn"), for: .normal)
        deleteBtn.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        contentView.addSubview(titleLab)
        contentView.addSubview(deleteBtn)
       
    }
    @objc func buttonClick(button:UIButton) {
        
        if let click = cellDeleteClick {
            click()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        deleteBtn.frame = CGRect(x: contentView.frame.size.width - 30, y: 0, width: 30, height: contentView.frame.size.height)
        titleLab.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 40, height: contentView.frame.size.height)
    }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
}
