//
//  PersonItemCell.swift
//  Dealers
//
//  Created by Black on 2017/8/15.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit

fileprivate let iconWidth = 16
fileprivate let pandingX = trueSize(20)

class PersonItemCell: UITableViewCell {

    fileprivate let iconImage = UIImageView()
    
    fileprivate let titleLabel = UILabel().then {
        $0.textColor = TITLE_COLOR
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    fileprivate let detialLabel = UILabel().then {
        $0.textColor = BODY_COLOR
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 14)
    }

    fileprivate let arrowIV = UIImageView().then {
        $0.image = UIImage(named: "p_arrow")
    }
    
    fileprivate let bottomLine = UIView().then {
        $0.backgroundColor = SUP_SEGMENT_COLOR
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildUI() {
        
        let arrowImage = UIImage(named: "p_arrow")
        
        self.contentView.addSubview(iconImage)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detialLabel)
        self.contentView.addSubview(arrowIV)
        self.contentView.addSubview(bottomLine)
        
        iconImage.snp.makeConstraints { (make) in
            make.left.equalTo(trueSize(20))
            make.centerY.equalTo(self)
            make.width.equalTo(iconWidth)
            make.height.equalTo(iconWidth)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImage.snp.right).offset(trueSize(10))
            make.centerY.equalTo(self)
            make.right.equalTo(self.snp.centerX)
        }
        
        detialLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX)
            make.centerY.equalTo(self)
            make.right.equalTo(arrowIV.snp.left).offset(-10)
        }
        
        arrowIV.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-pandingX)
            make.centerY.equalTo(self)
            make.width.equalTo((arrowImage?.size.width)!)
            make.height.equalTo((arrowImage?.size.height)!)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(trueSize(20))
            make.right.equalTo(self).offset(-pandingX)
            make.top.equalTo(self.snp.bottom).offset(trueSize(-1))
            make.height.equalTo(0.3)
        }
    }
    
//    MARK: 根据数据更新Cell
    func updateUI(iconName: String?, title: String?, _ detail: String? = nil, _ hiddenArrow: Bool = false) {
        iconImage.image = UIImage(named: iconName ?? "")
        titleLabel.text = title
        detialLabel.text = detail
        arrowIV.isHidden = hiddenArrow
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
