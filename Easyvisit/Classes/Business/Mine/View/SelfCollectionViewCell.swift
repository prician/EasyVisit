//
//  SelfCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/26.
//

import UIKit

class SelfCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        configUI()
        
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    lazy var rightView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "right"))
        imageView.frame = CGRect(x: 390, y: 20, width: 10, height: 10)
        return imageView
    }()
    
    lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()
    
    func configUI() {
        self.addSubview(titleLabel)
        self.addSubview(rightView)
        self.addSubview(answerLabel)
        
        titleLabel.snp.makeConstraints {make in
            make.left.equalToSuperview().offset(20)
            make.width.equalToSuperview().offset(50)
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(5)
        }
        
        answerLabel.snp.makeConstraints {make in
            make.right.equalToSuperview().offset(-50)
            make.width.equalToSuperview().offset(100)
            make.top.equalTo(titleLabel).offset(-5)
            make.height.equalToSuperview().offset(0)
        }
        
    }
    
    
    
}
