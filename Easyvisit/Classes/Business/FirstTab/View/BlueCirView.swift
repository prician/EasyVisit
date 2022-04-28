//
//  BlueCirView.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/28.
//

import UIKit

class BlueCirView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        configUI()
    }
    
    lazy var IntroLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 20)
        label.textAlignment = .left
        label.text = "今日心情指数 💕"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var indexLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 35)
        label.text = "85 %"
        label.textAlignment = .right
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    func configUI(){
        self.addSubview(IntroLabel)
        self.addSubview(indexLabel)
        
        IntroLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(35)
            make.width.equalTo(150)
        }
        
        indexLabel.snp.makeConstraints { make in
            make.top.equalTo(IntroLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(150)
        }
        
    }
    
}
