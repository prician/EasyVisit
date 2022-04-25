//
//  MedicineCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/24.
//

import UIKit

class MedicineCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        configUI()
        self.backgroundColor = .white
    }
    
    lazy var MediView:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.image = image
        imageView.layer.cornerRadius = 25
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var NameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "药品姓名"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var IntroLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 14)
        label.textAlignment = .left
        label.textColor = .gray
        label.text = "  介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍"
        label.numberOfLines = 0
        return label
    }()
    
    
    func configUI() {
        self.addSubview(MediView)
        self.addSubview(NameLabel)
        self.addSubview(IntroLabel)
        
        MediView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.height.width.equalTo(100)
            make.left.equalToSuperview().offset(20)
        }
        
        NameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(33)
            make.left.equalTo(MediView.snp.right).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(18)
        }
        
        IntroLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(42)
            make.left.equalTo(NameLabel)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(80)
        }
    }
}
