//
//  ScanInfoController.swift
//  AJPlusOCR
//
//  Created by Mac WuXinLing on 2018/1/16.
//  Copyright © 2018年 Black. All rights reserved.
//

import UIKit

class ScanInfoController: BaseViewController {

    fileprivate let  agencyLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.gray
        $0.textAlignment = .center
        $0.text = "经销商"
    }
    
    fileprivate let  agencyTextView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    fileprivate let  agencyTextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = UIColor.black
        $0.placeholder = "请输入经销商名称"
    }
    
    fileprivate let vinLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.gray
        $0.text = "VIN码"
    }
    
    fileprivate let vinTextView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    fileprivate let vinTextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = UIColor.black
        $0.placeholder = "请输入VIN码"
    }
    
    
    fileprivate let seatLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.gray
        $0.text = "座位号"
    }
    fileprivate let seatTextView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    fileprivate let seatTextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = UIColor.black
        $0.placeholder = "  请输入座位号"
    }
    
    fileprivate let carInfoImageView = UIImageView().then {
        $0.image = UIImage(named:"carInfo")
        
    }
    
    fileprivate let lineView = UIView().then {
        $0.backgroundColor = UIColor("F4F4F4")
    }
    
    
    fileprivate let backgroundView = UIView().then {
        $0.backgroundColor = UIColor.white
    }
    
    fileprivate let cancelButton = UIButton().then {
        $0.setTitle("取消", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
    }
    
    fileprivate let confirmButton = UIButton().then {
        $0.setTitle("确认", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.backgroundColor = BTN_HIGHT_BACKCOLOR
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        
    }
    
    @objc func cancelButtonClick(){
        print("取消")
    }
    
    @objc func confirmBtnClick(){
        print("确定")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "确认扫描信息"
        addSubView()
    }

    func addSubView(){
        
        self.view.addSubview(agencyLabel)
        agencyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(15)
            make.top.equalTo(self.view).offset(40)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        self.view.addSubview(agencyTextView)
        agencyTextView.snp.makeConstraints { (make) in
            make.left.equalTo(self.agencyLabel.snp.right).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-15)
            make.centerY.equalTo(self.agencyLabel)
            make.height.equalTo(50)
        }
        
        
        agencyTextView.addSubview(agencyTextField)
        agencyTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.agencyTextView).offset(10)
            make.right.equalTo(self.agencyTextView)
            make.centerY.equalTo(self.agencyTextView)
            make.height.equalTo(50)
        }
        
        
        self.view.addSubview(vinLabel)
        vinLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(15)
            make.top.equalTo(self.agencyLabel.snp.bottom).offset(40)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        self.view.addSubview(vinTextView)
        vinTextView.snp.makeConstraints { (make) in
            make.left.equalTo(self.vinLabel.snp.right).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-15)
            make.centerY.equalTo(self.vinLabel)
            make.height.equalTo(50)
        }
        
        
        vinTextView.addSubview(vinTextField)
        vinTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.vinTextView).offset(10)
            make.right.equalTo(self.vinTextView)
            make.centerY.equalTo(self.vinTextView)
            make.height.equalTo(50)
        }
        
        
        
        self.view.addSubview(seatLabel)
        seatLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.equalTo(60)
            make.top.equalTo(self.vinLabel.snp.bottom).offset(40)
        }
        
        self.view.addSubview(seatTextView)
        seatTextView.snp.makeConstraints { (make) in
            make.left.equalTo(self.seatLabel.snp.right).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-15)
            make.centerY.equalTo(self.seatLabel)
            make.height.equalTo(50)
        }
        
        seatTextView.addSubview(seatTextField)
        seatTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.seatTextView).offset(10)
            make.right.equalTo(self.seatTextView)
            make.centerY.equalTo(self.seatTextView)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(carInfoImageView)
        carInfoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.seatTextView.snp.bottom).offset(15)
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view.snp.right).offset(-15)
            make.height.equalTo(160)
        }
        
        self.view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.height.equalTo(60)
            make.bottom.equalTo(self.view.snp.bottom).offset(isIPhone8X ? -20:0)
            //            make.top.equalTo(self.carInfoImageView.snp.bottom).offset(10)
        }
        
        self.backgroundView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(self.backgroundView.snp.top).offset(0)
            make.width.equalTo(self.backgroundView.snp.width)
            make.height.equalTo(1)
        }
        
        self.backgroundView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.width.equalTo(140)
            make.height.equalTo(40)
            make.centerX.equalTo(self.backgroundView).offset(-80*UIRate)
        }
        
        
        self.backgroundView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.width.equalTo(140)
            make.height.equalTo(40)
            make.centerX.equalTo(self.backgroundView).offset(80*UIRate)
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
