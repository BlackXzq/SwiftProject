//
//  RegisterViewController.swift
//  Driver
//
//  Created by Black on 2017/11/6.
//  Copyright © 2017年 anji-allways. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    fileprivate let nameLabel = UILabel().then {
        $0.textColor = TITLE_COLOR
        $0.textAlignment = .right
        $0.text = "姓名："
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    fileprivate let nameTextF = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = TITLE_COLOR
        $0.placeholder = "请输入姓名"
        $0.borderStyle = .roundedRect
    }
    
    fileprivate let phoneLabel = UILabel().then {
        $0.textColor = TITLE_COLOR
        $0.textAlignment = .right
        $0.text = "手机号："
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    fileprivate let phoneTextF = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = TITLE_COLOR
        $0.placeholder = "请输入手机号"
        $0.keyboardType = .numberPad
        $0.borderStyle = .roundedRect
    }
    
    fileprivate let idLabel = UILabel().then {
        $0.textColor = TITLE_COLOR
        $0.textAlignment = .right
        $0.text = "身份证号："
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    fileprivate let idTextF = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = TITLE_COLOR
        $0.placeholder = "请输入身份证号"
        $0.borderStyle = .roundedRect
    }
    
    fileprivate let confirmBtn = SubmitButton().then {
        $0.frame = AJRect(0, 0, 200, 36)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: trueSize(16))
        $0.setTitle("确认", for: .normal)
        $0.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"

//        let cancelBtn = UIButton()
//        cancelBtn.frame = rect(0, 0, 50, 30)
//        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
//        cancelBtn.setTitleColor(UIColor.white, for: .normal)
//        cancelBtn.setTitle("取消", for: .normal)
//        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelBtn)
        
        
        self.view.addSubview(nameTextF)
        self.view.addSubview(nameLabel)
        self.view.addSubview(phoneLabel)
        self.view.addSubview(phoneTextF)
        self.view.addSubview(idLabel)
        self.view.addSubview(idTextF)
        self.view.addSubview(confirmBtn)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(20)
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        nameTextF.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right)
            make.right.equalTo(self.view).offset(-10)
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.height.equalTo(nameLabel)
        }
        
        phoneLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        phoneTextF.snp.makeConstraints { (make) in
            make.left.equalTo(phoneLabel.snp.right)
            make.right.equalTo(self.view).offset(-10)
            make.centerY.equalTo(phoneLabel.snp.centerY)
            make.height.equalTo(phoneLabel)
        }
        
        idLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(phoneLabel.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        idTextF.snp.makeConstraints { (make) in
            make.left.equalTo(idLabel.snp.right)
            make.right.equalTo(self.view).offset(-10)
            make.centerY.equalTo(idLabel.snp.centerY)
            make.height.equalTo(idLabel)
        }
        
        confirmBtn.snp.makeConstraints { (make) in
            make.top.equalTo(idLabel.snp.bottom).offset(40)
            make.width.equalTo(200)
            make.height.equalTo(36)
            make.centerX.equalTo(self.view)
        }
        
    }
    
//    @objc private func cancelBtnClick() {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    @objc private func confirmBtnClick() {
        guard let nameVale = nameTextF.text else {
            AJProgressHud.showText("姓名不能为空")
            return
        }
        
        if nameVale.isEmpty {
             AJProgressHud.showText("姓名不能为空")
            return
        }
        guard let phoneValue = phoneTextF.text else {
            AJProgressHud.showText("手机号不能为空")
            return
        }
        
        guard let idVlaue = idTextF.text else {
            AJProgressHud.showText("身份证号不能为空")
            return
        }
        
        
        if !phoneValue.isPhoneNumber() {
            AJProgressHud.showText("手机号码格式不正确")
            return
        }
        if !self.isIDNumber(value: idVlaue) {
            AJProgressHud.showText("身份证号格式不正确")
            return
        }
        
        AJProgressHud.showMessage("信息提交中...")
        
        let params: [String: Any] = [ "type":"5",]
        
        LDBaseReauest.sharedInstance.requestData(urlStrig: CheckEditionInformationKit, params: params, decodeClass: AppInfoEntity(), checkUserEmpty: false) { (value, classModel, resultCode) in
            AJProgressHud.hidHud()
            switch resultCode!{
            case  .ok:
                AJAlterView.showSigleAction(title: "提示", message: "您的信息已提交公司审核,请耐心等待", target: self, confirmTitle: "确认", confirmHandler: { [weak self] (acttion) in
                    self?.navigationController?.popViewController(animated: true)
                })
            case .failed:
                AJProgressHud.showText("信息提交异常")
            case .error:
                AJProgressHud.showText("网络异常")
            }
        }
    }
    
    
    func isIDNumber(value: String) -> Bool {
        if value.count == 0 {
            return false
        }
        let idNum = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let regexid = NSPredicate(format: "SELF MATCHES %@",idNum)
        if regexid.evaluate(with: value) == true {
            return true
        }else
        {
            return false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

