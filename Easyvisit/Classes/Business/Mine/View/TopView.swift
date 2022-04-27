//
//  TopView.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/23.
//

import UIKit
import SnapKit

class TopView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }

    
    lazy var Namelabel: UILabel = {
        let label = UILabel()
        label.text = "Prician"
        label.frame = CGRect(x: 20, y: 190, width: 200, height: 73)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 30)
        label.numberOfLines = 0
        return label
    }()

    lazy var Introlabel: UILabel = {
        let label = UILabel()
        label.text = "Be yourself Be yourself Be yourself"
        label.textColor = .gray
        label.frame = CGRect(x: 20, y: 190, width: 200, height: 73)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    func configUI() {
        self.addSubview(Namelabel)
        self.addSubview(Introlabel)
        
        Namelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        Introlabel.snp.makeConstraints { make in
            make.top.equalTo(Namelabel.snp.bottom).offset(10)
            make.left.equalTo(Namelabel)
            make.width.equalTo(350)
            make.height.equalTo(25)
        }
    }
    
    
}
