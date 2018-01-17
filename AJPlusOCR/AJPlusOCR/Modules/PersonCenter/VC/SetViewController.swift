//
//  SetViewController.swift
//  Dealers
//
//  Created by Black on 2017/8/14.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

fileprivate let ItemCellIdetifier = "LineItemCell"
fileprivate let btnHeight = trueSize(36)
fileprivate let CellHeight:CGFloat = 45

class SetViewController: BaseViewController {
    
    let logoutBtn = SubmitButton()
    let companyIV = UIImageView()
    let companyLabel = UILabel()
    let tableView = UITableView()
    
    fileprivate var dataList = [SetLineItem]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "设置"
        creatLocalData()
        buildUI()
    }
    
    fileprivate func buildUI() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.bounces = false
        tableView.separatorStyle = .none
        self.tableView.register(LineItemCell.self, forCellReuseIdentifier: ItemCellIdetifier)
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        
        logoutBtn.frame = AJRect(0, 0, trueSize(200), btnHeight)
        logoutBtn.titleLabel?.font = UIFont.systemFont(ofSize: trueSize(16))
        logoutBtn.setTitle("退出当前账户", for: .normal)
        logoutBtn.addTarget(self, action: #selector(logoutClick), for: .touchUpInside)
        self.tableView.addSubview(logoutBtn)
        
        let allCellHeight = CellHeight*CGFloat(Float(dataList.count))
        logoutBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.tableView)
            make.top.equalTo(allCellHeight + trueSize(54))
            make.width.equalTo(trueSize(224))
            make.height.equalTo(btnHeight)
        }
        
        let copyrightImg = UIImage(named: "copyright")
        companyIV.image = copyrightImg
        companyIV.contentMode = .scaleAspectFit
        self.view.addSubview(companyIV)
        companyIV.isHidden = true
        
        companyIV.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        
        companyLabel.textAlignment = .center
        companyLabel.font = UIFont.systemFont(ofSize: 14)
        companyLabel.text = "安吉加加信息技术有限公司"
        companyLabel.textColor = BODY_COLOR
        self.view.addSubview(companyLabel)
        companyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom).offset(-20)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(20)
        }
        
    }
    
    fileprivate func creatLocalData() {
        dataList.removeAll()
        let cacheSize = String(getAppCache()) + " M"
        let cacheItem = SetLineItem(newTitle: "清除缓冲", newDetail: cacheSize, newType: .clearCache)
        dataList.append(cacheItem)
        if AppUpdateManager.notInReviewing() {
            let versionItem = SetLineItem(newTitle: "检测最新版本", newDetail: AppUpdateManager.getAppVersion(), newType: .version)
            dataList.append(versionItem)
        }
        self.tableView.reloadData()
    }
    
    //    MARK:- 退出登陆
    @objc private func logoutClick() {
        AJAlterView.showTwoAction(title: "确定要退出登陆吗？", message: nil, target: self, confirmTitle: "退出登陆", confirmHandler: { (action) in
            LoginConfig.logOut()
        })
    }
    
    //    MARK:- 检查升级
    fileprivate func checkNewVersion() {
        AppUpdateManager.checkAppVersion { (isNew, message) in
            if !isNew {
                AJProgressHud.showText(message ?? "当前已是最新版本")
            }
        }
    }
    
    //    MARK:- 清除缓存
    fileprivate func clearCache() {
        if getAppCache() > 0 {
            AJAlterView.showTwoAction(title: "您确定要清除缓存数据吗？", message: nil, target: self, confirmTitle: "清除", confirmHandler: { [weak self] (action) in
                let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
                let fileArr = FileManager.default.subpaths(atPath: cachePath!)
                for file in fileArr! {
                    let path = (cachePath! as NSString).appending("/\(file)")
                    if FileManager.default.fileExists(atPath: path) {
                        do {
                            try FileManager.default.removeItem(atPath: path)
                        } catch {
                            
                        }
                    }
                }
                AJProgressHud.showText("清除缓存完成")
                self?.creatLocalData()
            })
        } else {
            AJAlterView.showSigleAction(title: "亲，暂无缓存可清除", message: nil)
        }
    }
    
    //获取缓存大小
    private func getAppCache() -> Int {
        
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        var size = 0
        for file in fileArr! {
            let path = (cachePath! as NSString).appending("/\(file)")
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            for (abc, bcd) in floder {
                // 累加文件大小
                if abc == FileAttributeKey.size {
                    size += (bcd as AnyObject).integerValue
                }
            }
        }
        
        let mm = size / 1024 / 1024
        return mm
    }
    
}

extension SetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LineItemCell = tableView.dequeueReusableCell(withIdentifier: ItemCellIdetifier, for: indexPath) as! LineItemCell
        cell.selectionStyle = .none
        cell.updateCell(item: dataList[indexPath.row], type: .setting)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item =  dataList[indexPath.row]
        switch item.type! {
        case .clearCache:  //清除缓存
            clearCache()
            break
        case .version:     //版本检测
            checkNewVersion()
            break
        case .helpCenter:   //帮助中心
            break
        case .ours:         //关于我们
            break
        default:
            break
        }
        printLog("item:\(item)")
    }
    
}
