//
//  OtherCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/23.
//

import UIKit

class OtherCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        configUI()
        
    }
    
    lazy var diarylabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 5, width: 100, height: 50)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = UIColor(red: 0.353, green: 0.358, blue: 0.367, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var diaryView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        //imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var rightView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "right")
        imageView.clipsToBounds = true
        //imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    func configUI() {
        self.addSubview(diarylabel)
        self.addSubview(diaryView)
        self.addSubview(rightView)
        
        diaryView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        diarylabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5.fh)
            make.height.equalTo(20)
            make.left.equalTo(diaryView.snp.right).offset(15)
            make.width.equalTo(100)
        }
        
        rightView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-30)
            make.width.equalTo(12)
            make.height.equalTo(12)
        }
        
    }
    
}
