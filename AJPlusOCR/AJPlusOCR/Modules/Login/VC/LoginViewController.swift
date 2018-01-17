//
//  LoginViewController.swift
//  AJPlusOCR
//
//  Created by Black on 2018/1/12.
//  Copyright © 2018年 Black. All rights reserved.
//

import UIKit

let pandWidth = trueSize(40)
let itemWitdh = (SCREENW - 2*trueSize(40))
let itemHeight = trueSize(36)

class LoginViewController: BaseViewController {

    let userNameBackView = UIView()
    let passWordBackView = UIView()
    let userNameTextF = UITextField()
    let passWordTextF = UITextField()
    let secureBtn = UIButton()
    let loginBtn = SubmitButton()
    let registerBtn = UIButton()
    let commpanyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        
        creatMainUI()
        
        NotificationCenter.default.addObserver(self, selector:#selector(textDidChanged(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        
        //添加debug入口
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapSelfViewClick))
        tapGesture.numberOfTapsRequired = 4
        #if DEBUG
            tapGesture.numberOfTouchesRequired = 1
        #else
            tapGesture.numberOfTouchesRequired = 2
        #endif
        commpanyLabel.isUserInteractionEnabled = true
        commpanyLabel.addGestureRecognizer(tapGesture)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLoginBtnState()
    }
    
    func creatMainUI() {
        
        userNameBackView.frame = AJRect(pandWidth, 45, itemWitdh, itemHeight)
        userNameBackView.layer.borderWidth = 1
        userNameBackView.layer.borderColor = SUP_SEGMENT_COLOR.cgColor
        userNameBackView.layer.cornerRadius = itemHeight*0.5
        self.view.addSubview(userNameBackView)
        
        userNameTextF.frame = AJRect(5, 0, userNameBackView.width-10, userNameBackView.height)
        userNameTextF.setFieldLeftView("login_userIcon")
        userNameTextF.delegate = self
        userNameTextF.keyboardType = .asciiCapable
        userNameTextF.clearButtonMode = .whileEditing
        userNameTextF.placeholder = "用户名"
        userNameBackView.addSubview(userNameTextF)
        
        
        passWordBackView.frame = AJRect(pandWidth, userNameBackView.bottom + 24, itemWitdh, itemHeight)
        passWordBackView.layer.borderWidth = 1
        passWordBackView.layer.borderColor = SUP_SEGMENT_COLOR.cgColor
        passWordBackView.layer.cornerRadius = itemHeight*0.5
        self.view.addSubview(passWordBackView)
        
        
        passWordTextF.frame = AJRect(5, 0, passWordBackView.width-45, itemHeight)
        passWordTextF.delegate = self
        passWordTextF.isSecureTextEntry = true
        passWordTextF.keyboardType = .numbersAndPunctuation
        passWordTextF.clearButtonMode = .whileEditing
        passWordTextF.setFieldLeftView("login_mima")
        passWordTextF.placeholder = "请输入密码"
        passWordBackView.addSubview(passWordTextF)
        
        secureBtn.frame = AJRect(passWordTextF.right, 0, itemHeight, itemHeight)
        secureBtn.setImage(UIImage(named: "login_xianshimima"), for: .selected)
        secureBtn.setImage(UIImage(named: "login_hidden_mima"), for: .normal)
        secureBtn.addTarget(self, action: #selector(secureBtnClick), for: .touchUpInside)
        passWordBackView.addSubview(secureBtn)
        
        
        loginBtn.frame = AJRect(pandWidth, passWordBackView.bottom + 54, itemWitdh, itemHeight)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: trueSize(16))
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        self.view.addSubview(loginBtn)
        
        registerBtn.frame = AJRect(pandWidth+itemWitdh-80, loginBtn.bottom + 20, 80, 20)
        registerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        registerBtn.setTitleColor(UIColor("2AB6EC"), for: .normal)
        registerBtn.setTitle("立即注册", for: .normal)
        registerBtn.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        self.view.addSubview(registerBtn)
        
        commpanyLabel.frame = AJRect(pandWidth, SCREENH-itemHeight-kNavigationBarH-kStatusBarH, itemWitdh, itemHeight)
        commpanyLabel.font = UIFont.systemFont(ofSize: 14)
        commpanyLabel.textAlignment = .center
        commpanyLabel.textColor = DESC_COLOR
        commpanyLabel.text = "安吉加加信息技术有限公司"
        self.view.addSubview(commpanyLabel)
        
    }
    //登录
    @objc private func loginClick() {
        
        self.view.endEditing(true)
        
        if (userNameTextF.text ?? "").isEmpty {
            AJProgressHud.showText("请输入账号")
            return
        }  else if (passWordTextF.text ?? "").isEmpty{
            AJProgressHud.showText("请输入密码")
            return
        }
         AJProgressHud.showMessage("登录中...")
        LoginVM.loginRequest(userName: userNameTextF.text!, passWord: passWordTextF.text!) { [weak self] (result) in
            AJProgressHud.hidHud()
            switch result{
            case  .ok:
                DispatchQueue.main.async {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.setRootHomeController()
                }
            case .failed(let message):
                AJProgressHud.showText(message)
            case .error:
                AJProgressHud.showText("登录失败，请检查网络")
            }
        }
        
    }
    //  注册
    @objc private func registerClick() {
        let registerCtl = RegisterViewController()
        self.navigationController?.pushViewController(registerCtl, animated: true)
    }
    
    //进入debug页面
    @objc private func tapSelfViewClick() {
        let debugCtl = DebugViewController()
        self.navigationController?.pushViewController(debugCtl, animated: true)
    }
    
    //是否显示密码
    @IBAction func secureBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passWordTextF.isSecureTextEntry = !sender.isSelected
    }

    //    MARK: 更新 登录btn状态变化
    
    @objc func textDidChanged(_ notification: Notification) {
        setLoginBtnState()
    }
    
    fileprivate func setLoginBtnState(){
        let userName = userNameTextF.text ?? ""
        let passWord = passWordTextF.text ?? ""
        if userName.count == 0 || passWord.count == 0 {
            loginBtnState(false)
        } else {
            loginBtnState(true)
        }
    }
        
    fileprivate func loginBtnState(_ isEnabled: Bool) {
        if isEnabled {
        loginBtn.fillColor = BTN_HIGHT_BACKCOLOR
        } else {
            loginBtn.fillColor = BTN_DIS_BACKCOLOR
        }
        loginBtn.isEnabled = isEnabled
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        loginBtnState(false)
        return true
    }
}

