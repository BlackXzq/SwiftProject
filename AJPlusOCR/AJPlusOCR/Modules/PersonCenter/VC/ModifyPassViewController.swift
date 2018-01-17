//
//  ModifyPassViewController.swift
//  Dealers
//
//  Created by Black on 2017/8/22.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit
import MBProgressHUD

class ModifyPassViewController: BaseViewController {

    @IBOutlet weak var oldPassTF: UITextField!
    @IBOutlet weak var showPassBtn: UIButton!
    @IBOutlet weak var newPassTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改密码"
        buildViews()
    }
    
    private func buildViews() {
        
        setsubmitBtnState()
        oldPassTF.delegate = self
        newPassTF.delegate = self
        oldPassTF.setFieldLeftView("login_mima")
        newPassTF.setFieldLeftView("login_mima")

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapSelfViewClick))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapSelfViewClick() {
        self.view.endEditing(true)
    }

    
    @IBAction func showPasswordClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        newPassTF.isSecureTextEntry = !sender.isSelected
    }

//    MARK:- 提交修改密码请求
    @IBAction func submitBtnClick(_ sender: UIButton) {

        guard let oldPass = oldPassTF.text else {
            return
        }
        guard let newPass = newPassTF.text else {
            return
        }
        
        if !oldPass.isValid() || oldPass.count < 6 || oldPass.count > 20 {
            AJProgressHud.showText("请输入有效的原密码")
            return
        }
        
        if !newPass.isValid() || newPass.count < 6 || newPass.count > 20 {
            AJProgressHud.showText("请设置6-20位有效密码格式")
            return
        }
        
        if oldPass == newPass {
            AJProgressHud.showText("原密码与新密码不能相同")
            return
        }
        
        if !newPass.validatePassword() {
            AJProgressHud.showText("请输入6-20位,由字母、数字组合")
            return
        }
        AJProgressHud.showMessage("密码修改中...")
        ModifyPasswordVM.modifyPasswordRequest(oldPassword: oldPassTF.text ?? "", newPassword: newPassTF.text ?? "") { [weak self] (result) in
            AJProgressHud.hidHud()
            switch result{
            case  .ok:
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: false)
                    LoginConfig.logOut()
                    AJProgressHud.showText("密码修改成功，请重新登陆", 5)
                }
            case .failed(let message):
                AJProgressHud.showText(message)
            case .error:
                AJProgressHud.showText("修改密码失败，请重试")
            }
        }
    }
    
    fileprivate func setsubmitBtnState(){
        let oldPassValue = oldPassTF.text ?? ""
        let newPassVlaue = newPassTF.text ?? ""
        if oldPassValue.count > 0 &&  newPassVlaue.count > 0 {
            submitBtnState(true)
        } else {
            submitBtnState(false)
        }
    }
    
    fileprivate func submitBtnState(_ isEnabled: Bool) {
        if isEnabled {
            submitBtn.backgroundColor = BTN_HIGHT_BACKCOLOR
        } else {
            submitBtn.backgroundColor = BTN_DIS_BACKCOLOR
        }
        submitBtn.isEnabled = isEnabled
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}

extension ModifyPassViewController: UITextFieldDelegate {
    
    //MARK: -- UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " {
            return false
        }
        let currentText = textField.text ?? ""
        if currentText.count > 19 {
            return false
        }
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let isEnable: Bool = newText.count > 0
        
        let oldPassValue = oldPassTF.text ?? ""
        let newPassVlaue = newPassTF.text ?? ""
        
        if textField.isEqual(oldPassTF) {
            if newPassVlaue.count > 0 && isEnable{
                submitBtnState(true)
            }else {
                submitBtnState(false)
            }
        } else {
            if oldPassValue.count > 0 && isEnable{
                submitBtnState(true)
            }else {
                submitBtnState(false)
            }
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        setsubmitBtnState()
        submitBtnState(false)
        return true
    }
    
    
    
    
    
    
}
