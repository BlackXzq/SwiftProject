//
//  LineItemView.swift
//  Dealers
//
//  Created by Black on 2017/8/14.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit

enum LineItemViewType {
    case setting  //设置
    case userInfo //个人信息
}

fileprivate let pandX = trueSize(20)

class LineItemView: UIView {
    
    fileprivate let titleLabel = UILabel().then {
        $0.textColor = BODY_COLOR
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    fileprivate let detailLabel = UILabel().then {
        $0.textColor = TITLE_COLOR
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    fileprivate let arrowIV = UIImageView().then {
        $0.image = UIImage(named: "p_arrow")
    }
    
    fileprivate let bottomLine = UIView().then {
        $0.backgroundColor = SUP_SEGMENT_COLOR
    }
    
    fileprivate let arrowImage = UIImage(named: "p_arrow")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }

    private func initViews() {
        
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        self.addSubview(arrowIV)
        self.addSubview(bottomLine)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(pandX)
            make.centerY.equalTo(self)
            make.width.equalTo(100)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.centerY.equalTo(self)
            make.right.equalTo(self.arrowIV.snp.left).offset(-10)
        }
        
        arrowIV.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-pandX)
            make.centerY.equalTo(self)
            make.width.equalTo((arrowImage?.size.width)!)
            make.height.equalTo((arrowImage?.size.height)!)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(pandX)
            make.right.equalTo(self).offset(-pandX)
            make.top.equalTo(self.snp.bottom).offset(-trueSize(1))
            make.height.equalTo(0.3)
        }
        
        updateUILayout(type: .setting)
        
    }
    
    func updateUILayout(type: LineItemViewType) {
        detailLabel.textAlignment = .right
//        if type == .setting {
//            detailLabel.textAlignment = .right
//        } else {
//            detailLabel.textAlignment = .left
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LineItemView {
    func updateData(_ item: SetLineItem) {
        arrowIV.isHidden = (item.type == .normal)
        titleLabel.text = item.title
        detailLabel.text = item.detail
    }
}
