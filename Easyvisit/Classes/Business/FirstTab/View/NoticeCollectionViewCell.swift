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
        label.textColor = .white
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 12)
        label.textColor = .systemGray5
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 14)
        label.textColor = .white
        return label
    }()
    
    lazy var dateImageView: UIImageView = {
        let imgv = UIImageView()
        return imgv
    }()
    
    lazy var timeImageView: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
 
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 12)
        label.textAlignment = .left
        label.textColor = .white
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
    
    lazy var bottomView: UIView = {
        let vi = UIView()
        vi.layer.cornerRadius = 8
        return vi
    }()
    
    @objc func answerClick() {
        
    }
    
    func configUI(){
        self.addSubview(WhiteView)
        WhiteView.addSubview(nameLabel)
        WhiteView.addSubview(descLabel)
        WhiteView.addSubview(leftView)
        WhiteView.addSubview(bottomView)
        WhiteView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        leftView.snp.makeConstraints { maker in
            maker.top.left.equalToSuperview().offset(10)
            maker.width.height.equalTo(30)
        }
        nameLabel.snp.makeConstraints { maker in
            maker.top.equalTo(leftView)
            maker.left.equalTo(leftView.snp.right).offset(15)
        }
        descLabel.snp.makeConstraints { maker in
            maker.left.equalTo(nameLabel)
            maker.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        bottomView.snp.makeConstraints { maker in
            maker.left.equalTo(leftView)
            maker.bottom.right.equalToSuperview().offset(-10)
            maker.height.equalTo(60)
        }
        bottomView.addSubview(dateImageView)
        bottomView.addSubview(dateLabel)
        bottomView.addSubview(timeImageView)
        bottomView.addSubview(timeLabel)
        dateImageView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(10)
            maker.centerY.equalToSuperview()
        }
        dateLabel.snp.makeConstraints { maker in
            maker.left.equalTo(dateImageView.snp.right).offset(15)
            maker.centerY.equalToSuperview()
        }
        timeImageView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalTo(bottomView.snp.centerX)
        }
        timeLabel.snp.makeConstraints { maker in
            maker.left.equalTo(timeImageView.snp.right).offset(15)
            maker.centerY.equalToSuperview()
        }
        
    }
    
}
