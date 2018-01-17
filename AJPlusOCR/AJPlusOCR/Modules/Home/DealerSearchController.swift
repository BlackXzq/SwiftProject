//
//  DealerSearchController.swift
//  AJPlusOCR
//
//  Created by WuXingLin on 2018/1/17.
//  Copyright © 2018年 Black. All rights reserved.
//

import UIKit

class DealerSearchController: BaseViewController,UITextFieldDelegate {

    fileprivate let searchView = UIView().then {
        $0.backgroundColor = UIColor.clear
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 25
        $0.isUserInteractionEnabled = true
    }
    
    fileprivate let dealerLabel = UITextField().then{
        $0.placeholder = "查询经销商名称"
        $0.textColor = NAV_BG_COLOR
    }
    
    fileprivate let searchImageView = UIButton().then{
        $0.setImage(UIImage(named: "sao-hei"), for: .normal)
        $0.addTarget(self, action: #selector(searchButtonClick), for: .touchUpInside)
    }

    
    @objc func searchButtonClick(){
        print("搜索")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "经销商查询"
        self.navigationController?.navigationBar.isHidden = false
        
        addSubview()
    }
    
    
    func addSubview(){
        
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view).offset(-15)
            make.top.equalTo(self.view).offset(10)
            make.height.equalTo(50)
        }
        
        
        self.searchView.addSubview(dealerLabel)
        dealerLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-40)
            make.height.equalTo(30)
            make.top.equalTo(10)
        }
        
        self.searchView.addSubview(searchImageView)
        searchImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(self.searchView.snp.centerY)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
