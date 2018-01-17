//
//  LineItemCell.swift
//  Dealers
//
//  Created by Black on 2017/8/14.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit

class LineItemCell: UITableViewCell {

    fileprivate let itemView = LineItemView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        self.contentView.addSubview(itemView)
        
        itemView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
    func updateCell(item: SetLineItem, type: LineItemViewType) {
        itemView.updateData(item)
        itemView.updateUILayout(type: type)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
