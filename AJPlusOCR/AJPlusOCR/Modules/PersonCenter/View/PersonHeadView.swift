//
//  PersonHeadView.swift
//  Dealers
//
//  Created by Black on 2017/8/15.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit

fileprivate let backImageHeight = trueSize(108+kStatusBarH)
fileprivate let dealerIconWidth = trueSize(74)
fileprivate let iconBackWidth = trueSize(80)

class PersonHeadView: UIView {
    
    private let titleLabel = UILabel()
    private let backIV = UIImageView()
    private let dealerIConIV = UIImageView()
    private let dealerNameLabel = UILabel()
    private let iconBackView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor("ffffff")
        
        buildUI()
    }
    
    func buildUI() {
        
        backIV.image = UIImage(named: "gerenzhongxin_head")
        self.addSubview(backIV)
        
        titleLabel.text = "个人中心"
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        titleLabel.textColor = NAV_TITLE_BAR_COLOR
        self.addSubview(titleLabel)
        
        iconBackView.backgroundColor = UIColor.white
        iconBackView.layer.cornerRadius = iconBackWidth * 0.5
        iconBackView.layer.masksToBounds = true
        self.addSubview(iconBackView)
        
        dealerIConIV.layer.cornerRadius = dealerIconWidth * 0.5
        dealerIConIV.layer.masksToBounds = true
        self.addSubview(dealerIConIV)
        
        dealerNameLabel.font = UIFont.systemFont(ofSize: 14)
        dealerNameLabel.textAlignment = .center
        dealerNameLabel.textColor = BODY_COLOR
        self.addSubview(dealerNameLabel)
        
        backIV.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(backImageHeight)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(kStatusBarH)
            make.height.equalTo(44)
        }
        
        iconBackView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(backIV.snp.bottom)
            make.width.equalTo(iconBackWidth)
            make.height.equalTo(iconBackWidth)
        }
        
        dealerIConIV.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconBackView.snp.centerX)
            make.centerY.equalTo(iconBackView.snp.centerY)
            make.width.equalTo(dealerIconWidth)
            make.height.equalTo(dealerIconWidth)
        }
        
        dealerNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(dealerIConIV.snp.bottom).offset(trueSize(5))
            make.height.equalTo(20)
        }
    }
    
//    MARK: 根据数据更新UI
    func updateHeadView(dealerName: String, dealerIcon: String?) {
        dealerNameLabel.text = dealerName
        if dealerIcon != nil {
            let iconUrl = URL(string: dealerIcon!)
            dealerIConIV.kf.setImage(with: URL(string: dealerIcon ?? ""), placeholder: UIImage(named: "morentouxiang"))
        } else {
            dealerIConIV.image = UIImage(named: "morentouxiang")
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
