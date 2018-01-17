//
//  DebugViewController.swift
//  Driver
//
//  Created by Black on 2017/10/10.
//  Copyright © 2017年 anji-allways. All rights reserved.
//

import UIKit

fileprivate let DebugItemCellIdetifier = "DebugItemCellIdetifier"

class DebugViewController: BaseViewController {
    
    fileprivate var segmented:UISegmentedControl!
    fileprivate let keyItems = AJDebugManager.allModeKey()
    fileprivate var dataList = [ItemModel]()
    fileprivate let titleItems = ["生产", "预发", "测试", "开发", "个人"];
    fileprivate let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Debug"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(changeCompleted))
        
        segmented = UISegmentedControl(items: titleItems)
        self.view.addSubview(segmented)
        segmented.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(40)
        }
        segmented.selectedSegmentIndex = AJDebugManager.shareHelper.activeMode().rawValue
        segmented.addTarget(self, action: #selector(changeSegmentClick(_:)), for: .valueChanged)
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.register(DebugItemCell.self, forCellReuseIdentifier: DebugItemCellIdetifier)
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.segmented.snp.bottom).offset(5)
        }
        
        creatConfigure(mode: AJDebugManager.shareHelper.activeMode())
    }
    
    private func creatConfigure(mode: AJNetworkDebugMode) {
        dataList.removeAll()
        let configure = AJDebugManager.shareHelper.getActiveConfigure(mode)
        for (key, vlaue) in configure.valueDict {
            let itemModel = ItemModel()
            itemModel.title = key
            itemModel.value = vlaue
            dataList.append(itemModel)
        }
        self.tableView.reloadData()
    }
    
    @objc private func changeCompleted() {
        printLog("segmented:\(segmented.selectedSegmentIndex)")
        
        self.view.endEditing(true)
        
        if self.toAJNetworkDebugMode(segmented.selectedSegmentIndex) == AJDebugManager.shareHelper.activeMode() {
            self.saveChangeValue()//改变修改的数据
            self.navigationController?.popViewController(animated: true)
            return
        } else {
            AJAlterView.showTwoAction(title: "确认切换环境吗", message: nil, target: self, confirmHandler: { [weak self] (action) in
                self?.saveChangeValue()//改变修改的数据
                AJDebugManager.shareHelper.switchMode(mode: (self?.toAJNetworkDebugMode((self?.segmented.selectedSegmentIndex)!))!, true)
                self?.navigationController?.popViewController(animated: true)
            })
        }
    }
    
    @objc private func changeSegmentClick(_ sender: UISegmentedControl) {
        printLog("sender:\(sender.selectedSegmentIndex)")
        self.creatConfigure(mode: self.toAJNetworkDebugMode(sender.selectedSegmentIndex))
    }
    
    private func saveChangeValue() {
        for item in dataList {
            if item.title != nil && item.value != nil {
                switch self.toAJNetworkDebugMode(self.segmented.selectedSegmentIndex) {
                case .personal:
                    AJDebugManager.shareHelper.addAPI(item.title!, nil, nil, nil, nil, item.value)
                case .developer:
                    AJDebugManager.shareHelper.addAPI(item.title!, nil, nil, nil, item.value, nil)
                case .tester:
                    AJDebugManager.shareHelper.addAPI(item.title!, nil, nil, item.value, nil, nil)
                case .staging:
                    AJDebugManager.shareHelper.addAPI(item.title!, nil, item.value, nil, nil, nil)
                default:
                    AJDebugManager.shareHelper.addAPI(item.title!, item.value, nil, nil, nil, nil)
                }
            }
        }
    }
    
    private func toAJNetworkDebugMode(_ index: Int) -> AJNetworkDebugMode {
        if index < titleItems.count {
            let selectTitle = titleItems[index]
            switch selectTitle {
            case "生产":
                return .producter
            case "预发":
                return .staging
            case "测试":
                return .tester
            case "开发":
                return .developer
            case "个人":
                return .personal
            default:
                return .producter
            }
        }
        return .producter
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DebugViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataList[indexPath.row]
        let cell:DebugItemCell = tableView.dequeueReusableCell(withIdentifier: DebugItemCellIdetifier, for: indexPath) as! DebugItemCell
        cell.updateUI(model: model)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

class DebugItemCell: UITableViewCell {
    
    let titleLabel = UILabel().then {
        $0.textColor = TITLE_COLOR
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let contentTextF = UITextField().then {
        $0.textColor = BODY_COLOR
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    var tempModel:ItemModel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(contentTextF)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.top.bottom.equalTo(self.contentView)
            make.width.equalTo(130)
        }
        
        contentTextF.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-5)
            make.left.equalTo(titleLabel.snp.right).offset(5)
        }
        
        contentTextF.addTarget(self, action: #selector(textFiledValueChange), for: .allEditingEvents)
    }
    
    func updateUI(model: ItemModel) {
        tempModel = model
        self.titleLabel.text = model.title
        self.contentTextF.text = model.value
    }
    
    @objc private func textFiledValueChange() {
        printLog("textFiledValueChange: \(contentTextF.text ?? "")")
        if tempModel != nil {
            tempModel?.value = contentTextF.text
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class ItemModel: NSObject {
    var title: String?
    var value: String?
}


