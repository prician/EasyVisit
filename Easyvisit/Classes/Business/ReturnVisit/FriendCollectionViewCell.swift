//
//  DoctorCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/23.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
        //self.backgroundColor = .white
    }
    
    
    lazy var FriNamelabel: UILabel = {
        let label = UILabel()
        label.text = "朋友姓名"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var FriIntrolabel: UILabel = {
        let label = UILabel()
        label.text = "个人介绍（个性签名）"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var BackView:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.backgroundColor = .blue
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    func configUI() {
        self.addSubview(FriNamelabel)
        self.addSubview(FriIntrolabel)
        self.addSubview(BackView)
        
        BackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.fh)
            make.left.equalToSuperview().offset(15.fw)
            make.width.height.equalTo(45)
        }
        
        FriNamelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.fh)
            make.height.equalTo(20)
            make.left.equalTo(BackView.snp.right).offset(30.fw)
            make.width.equalToSuperview()
        }
        
        FriIntrolabel.snp.makeConstraints { make in
            make.top.equalTo(FriNamelabel.snp.bottom).offset(10)
            make.height.equalTo(15)
            make.left.equalTo(BackView.snp.right).offset(30.fw)
            make.width.equalToSuperview()
        }
        
    }
    
}
