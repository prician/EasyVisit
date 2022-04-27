//
//  HistoryCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/26.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        configUI()
        self.backgroundColor = .white
    }
    
    lazy var DateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var indexLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textAlignment = .right
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    func configUI(){
        self.addSubview(DateLabel)
        self.addSubview(indexLabel)
        
        DateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        indexLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-50)
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.equalTo(DateLabel)
        }
        
    }
    
}
