//
//  HistoryTopCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/26.
//

import UIKit

class HistoryTopCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        configUI()
        self.backgroundColor = .white
    }
    
    lazy var WhiteView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 14
        layerView.alpha = 1
        let label = UILabel(frame: CGRect(x: 50, y: 5, width: 100, height: 30))
        label.text = "历史数据"
        layerView.addSubview(label)
        return layerView
    }()
    
    lazy var DateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.text = "日期 📅"
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var DataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.text = "指标 📝"
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    func configUI(){
        self.addSubview(WhiteView)
        self.addSubview(DateLabel)
        self.addSubview(DataLabel)
        
        WhiteView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(100)
            make.width.equalTo(170)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(10)
        }
        
        DateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.top.equalTo(WhiteView.snp.bottom).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        DataLabel.snp.makeConstraints { make in
            make.left.equalTo(DateLabel.snp.right).offset(100)
            make.top.equalTo(DateLabel)
            make.height.width.equalTo(DateLabel)
        }
        
    }
    
}
