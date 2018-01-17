//
//  PersonCenterViewController.swift
//  Dealers
//
//  Created by Black on 2017/8/11.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit

let PersonItemCellIdtifier = "PersonItemCellIdtifier"

enum PersonItemType: Int {
    case name = 0
    case mobile
    case updatePassword
    case setting
}

struct PersonItem {
    var iconName: String?
    var title: String?
    var type: PersonItemType?
    var hiddenArrow: Bool = false
    var detail: String?
    
    init(newTitle: String?, newdetail: String? ,newIconName: String?, newType: PersonItemType, newhiddenArrow: Bool) {
        title = newTitle
        iconName = newIconName
        type = newType
        detail = newdetail
        hiddenArrow = newhiddenArrow
    }
}

class PersonCenterViewController: BaseViewController {
    
    fileprivate var headView: PersonHeadView?
    fileprivate var dataList = [PersonItem]()
    fileprivate let tableView = UITableView()
    fileprivate let builNumLabel = UILabel().then {
        $0.textColor = TITLE_COLOR
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewConfig()
        creatMainView()
    }
    
    //初始化Ui相关显示
    private func initViewConfig() {
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.sh_prefersNavigationBarHidden = true
    }
    
    private func creatMainView() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.bounces = false
        tableView.separatorStyle = .none
        self.tableView.register(PersonItemCell.self, forCellReuseIdentifier: PersonItemCellIdtifier)
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        headView = PersonHeadView(frame: AJRect(0, 0, self.view.width, trueSize(196+kStatusBarH)))
        self.tableView.tableHeaderView = headView
        
        #if DEBUG
            self.view.addSubview(builNumLabel)
            builNumLabel.snp.makeConstraints { (make) in
                make.left.right.equalTo(self.view)
                make.bottom.equalTo(self.view).offset(-kTabbarH)
                make.height.equalTo(20)
            }
        #endif
        
        let btn = UIButton()
        btn.setImage(UIImage(named: "nav_back_img"), for: .normal)
        btn.frame = AJRect(0, kStatusBarH, 40, 40)
        btn.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        self.view.addSubview(btn)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        creatLocalData()
        
        #if DEBUG
            builNumLabel.text = "(\(AJDebugManager.shareHelper.activeMode()))" + "build: " + AppUpdateManager.getAppBuildNum()
        #endif
    }
    
    func creatLocalData() {
        
        dataList.removeAll()
        let userModel = UserModel.loadUserInfo()
        headView?.updateHeadView(dealerName: userModel?.name ?? "", dealerIcon: nil)

        let item1 = PersonItem(newTitle: "个人信息", newdetail: userModel?.name ?? "", newIconName: "perosn_info", newType: .name, newhiddenArrow: true)
        let item2 = PersonItem(newTitle: "修改密码", newdetail: nil, newIconName: "person_update_password", newType: .updatePassword, newhiddenArrow: false)
        let item3 = PersonItem(newTitle: "设置", newdetail: nil, newIconName: "person_setting", newType: .setting, newhiddenArrow: false)
        dataList.append(item1)
        dataList.append(item2)
        dataList.append(item3)
        
        self.tableView.reloadData()
    }
    
    
    //    MARK: 页面跳转
    func skipControler(type: PersonItemType, _ item: PersonItem) {
        switch type {
        case .updatePassword:
            let modifyCtl = ModifyPassViewController()
            self.navigationController?.pushViewController(modifyCtl, animated: true)
            break;
        case .setting:
            let setCtroller = SetViewController()
            self.navigationController?.pushViewController(setCtroller, animated: true)
            break
        case .mobile:
//            if item.detail != nil {
//                 UIApplication.shared.openURL(URL(string: "telprompt://\(item.detail!)")!)
//            }
            break
        default: break
        }
    }
    
    @objc private func backButtonClick() {
        self.navigationController?.popViewController(animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //    MARK: 测试接口
    //获取经销商列表信息
    func getDealersData() {
        GetDealerListVM.requesDealersList(name: "") { (result, entity) in
            switch result{
            case  .ok(let message):
                printLog(message)
            case .failed(let message):
                printLog(message)
            case .error(let error):
                printLog(error)
            }
        }
    }
    
    //提交车辆信息到仓库
    func postCarInfo() {
        
        let customerID = "30"
        let customerName = "上海汽车物流"
        let vin = "LS5A3ADE0AB046793"
        let location = "B-2"
        AJProgressHud.showMessage("信息提交中...")
        AddCarInfoToStoreVM.postCarInforToStoreRequest(customerId: customerID, customerName: customerName, vin: vin, location: location) { [weak self] (result) in
            AJProgressHud.hidHud()
            switch result{
            case  .ok:
                delay(0.5, closure: {
                    AJProgressHud.showText("交接成功")
                })
                self?.navigationController?.popToRootViewController(animated: true)
            case .failed(let message):
                AJProgressHud.showText(message)
            case .error:
                AJProgressHud.showText("交接失败，请检查网络")
            }
        }
    }
    
    
}

extension PersonCenterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PersonItemCell = tableView.dequeueReusableCell(withIdentifier: PersonItemCellIdtifier, for: indexPath) as! PersonItemCell
        cell.selectionStyle = .none
        let tempItem = dataList[indexPath.row]
        cell.updateUI(iconName: tempItem.iconName, title: tempItem.title, tempItem.detail, tempItem.hiddenArrow)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item =  dataList[indexPath.row]
        skipControler(type: item.type!, item)
    }
    
}




