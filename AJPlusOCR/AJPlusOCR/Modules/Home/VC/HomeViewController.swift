//
//  HomeViewController.swift
//  AJPlusOCR
//
//  Created by Black on 2018/1/15.
//  Copyright © 2018年 Black. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    fileprivate let backgroundImageView = UIImageView().then {
        $0.image = UIImage(named:"beijingtu")
    }
    
    fileprivate let userSettingButton = UIButton().then {
        $0.frame = CGRect(x:0, y:0, width:30, height:30)
        $0.setImage(UIImage(named: "geren"), for: .normal)
        $0.addTarget(self, action: #selector(userSettingButtonClick), for: .touchUpInside)
    }
    
    fileprivate let titleLabel = UILabel().then {
        $0.text = "车辆信息录入"
        $0.textColor = UIColor.white
        $0.font = UIFont.systemFont(ofSize: 20)
    }
    
    
    fileprivate let logoutButton = UIButton().then {
        $0.frame = CGRect(x:0, y:0, width:30, height:30)
        $0.setImage(UIImage(named: "tuichu"), for: .normal)
        $0.addTarget(self, action: #selector(logoutButtonClick), for: .touchUpInside)
    }
    
    fileprivate let searchView = UIView().then {
        $0.backgroundColor = UIColor.clear
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 25
        $0.isUserInteractionEnabled = true
    }
    
    fileprivate let dealerLabel = UILabel().then{
        $0.text = "选择经销商名称"
        $0.textColor = UIColor.white
    }
    
    fileprivate let searchImageView = UIImageView().then{
        $0.image = UIImage(named:"sao-bai")
    }
    
    
    
    fileprivate let photoButton = UIButton().then {
        $0.frame = CGRect(x:0, y:0, width:100, height:100)
        $0.setImage(UIImage(named: "xiangse"), for: .normal)
        $0.addTarget(self, action: #selector(photoButtonClick), for: .touchUpInside)
    }
    
    fileprivate let photoLabel = UILabel().then {
        $0.text = "相册录入"
        $0.textColor = UIColor.white
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    
    fileprivate let scanButton = UIButton().then {
        $0.frame = CGRect(x:0, y:0, width:100, height:100)
        $0.setImage(UIImage(named: "saoma"), for: .normal)
        $0.addTarget(self, action: #selector(scanButtonClick), for: .touchUpInside)
    }
    
    fileprivate let scanLabel = UILabel().then {
        $0.text = "扫码录入"
        $0.textColor = UIColor.white
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    @objc func tapGestureClick(){
        
        let dealerVC = DealerSearchController()
        self.navigationController?.pushViewController(dealerVC, animated: true)
    }
    
    //MARK:设置
    @objc func userSettingButtonClick(){
        let personCtl = PersonCenterViewController()
        self.navigationController?.pushViewController(personCtl, animated: true)
    }
    //MARK:退出账号
    @objc func logoutButtonClick(){
        LoginConfig.logOut()
    }
    
    //MARK:相册录入
    @objc func photoButtonClick(){
        
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.delegate = self
            

            picker.navigationBar.barTintColor = UIColor.red
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //设置是否允许编辑
            picker.allowsEditing = true
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }
    }
    
    //MARK:扫码录入
    @objc func scanButtonClick(){
        
        let scanInfoVC = ScanInfoController()
        self.navigationController?.pushViewController(scanInfoVC, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        addSubView()
        
    }
    
    //MARK:增加子视图
    func addSubView(){
        
        self.view.addSubview(self.backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            
            make.width.height.equalToSuperview()
            
        }
        
        self.view.addSubview(self.userSettingButton)
        userSettingButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.backgroundImageView).offset(15)
            make.top.equalTo(self.backgroundImageView).offset(40)
        }
        
        self.view.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.backgroundImageView).offset(40)
        }
        
        self.view.addSubview(self.logoutButton)
        logoutButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.backgroundImageView).offset(-20)
            make.top.equalTo(self.backgroundImageView).offset(40)
        }
        
        self.view.addSubview(self.searchView)
        searchView.snp.makeConstraints { (make) in
            make.left.equalTo(self.userSettingButton.snp.left).offset(0)
            make.right.equalTo(self.logoutButton.snp.right).offset(0)
            make.top.equalTo(self.userSettingButton.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        let tapGesture = UITapGestureRecognizer(target:self,action:#selector(tapGestureClick))
        searchView.addGestureRecognizer(tapGesture)
        
        self.searchView.addSubview(dealerLabel)
        dealerLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-60)
            make.height.equalTo(30)
            make.top.equalTo(10)
        }
        
        self.searchView.addSubview(searchImageView)
        searchImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(self.searchView.snp.centerY)
            
        }
        
        self.view.addSubview(self.photoButton)
        photoButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view).offset(-75*UIRate)
            make.centerY.equalTo(self.view).offset(-60*UIRate)
            
        }
        self.view.addSubview(self.photoLabel)
        photoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.photoButton.snp.bottom).offset(10)
            make.centerX.equalTo(self.photoButton.snp.centerX)
            
        }
        
        
        
        self.view.addSubview(self.scanButton)
        scanButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view).offset(75*UIRate)
            make.centerY.equalTo(self.view).offset(-60*UIRate)
        }
        self.view.addSubview(self.scanLabel)
        scanLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.scanButton.snp.bottom).offset(10)
            make.centerX.equalTo(self.scanButton.snp.centerX)
            
        }
        
        
        
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



//MARK: 相册选择代理
func imagePickerController(_ picker: UIImagePickerController,
                           didFinishPickingMediaWithInfo info: [String : Any]) {
    print(info)
    let image:UIImage!
    image = info[UIImagePickerControllerOriginalImage] as! UIImage
    picker.dismiss(animated: true, completion: {
        () -> Void in
    })
}








