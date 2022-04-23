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
    
    lazy var headView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "lanzhouback"))
        imageView.image = UIImage(named: "head")
        imageView.layer.cornerRadius  = 20
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: Int(screenWidth).fw, height: 311.fh)
        return imageView
    }()

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
        self.addSubview(headView)
        self.addSubview(Namelabel)
        self.addSubview(Introlabel)
        
        headView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-50)
            make.width.height.equalTo(70.fw)
            make.top.equalToSuperview().offset(70.fw)
        }
        Namelabel.snp.makeConstraints { make in
            make.top.equalTo(headView).offset(-10)
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
