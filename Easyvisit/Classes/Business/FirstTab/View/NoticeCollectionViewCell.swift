//
//  NoticeCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/22.
//

import UIKit

class NoticeCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        configUI()
    }
    
    lazy var WhiteView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20).cgColor
        layerView.layer.shadowOffset = CGSize(width: 1, height: 1)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 15
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
 
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 12)
        label.textAlignment = .left
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var leftView:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    lazy var rightbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "true"), for: .normal)
        button.addTarget(self, action: #selector(answerClick), for: .touchUpInside)
        return button
    }()
    
    @objc func answerClick() {
        
    }
    
    func configUI(){
        self.addSubview(WhiteView)
        WhiteView.addSubview(nameLabel)
        WhiteView.addSubview(leftView)
        WhiteView.addSubview(timeLabel)
        WhiteView.addSubview(rightbutton)
        
        WhiteView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
        }
        
        leftView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.fh)
            make.left.equalToSuperview().offset(20.fw)
            make.width.height.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.fh)
            make.left.equalTo(leftView.snp.right).offset(40)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(nameLabel)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        rightbutton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel).offset(10)
            make.height.width.equalTo(20)
            make.right.equalToSuperview().offset(-25)
        }
        
    }
    
}
