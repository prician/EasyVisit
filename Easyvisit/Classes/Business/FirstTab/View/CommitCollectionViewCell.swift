//
//  CommitCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/24.
//

import UIKit

class CommitCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        configUI()
        self.backgroundColor = .white
    }
    
    lazy var PhotoView:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "photo")
        imageView.image = image
        imageView.layer.cornerRadius = 25
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var NameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 20)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "姓名"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var TimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 12)
        label.textAlignment = .left
        label.textColor = .gray
        label.text = "时间时间时间时间时间时间时间时间"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var ContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 14)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "我好开心 我好开心 我好开心 我好开心 我好开心"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var View1:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "pic-1")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var View2:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "pic-2")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var pic1:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "pic-3")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var pic2:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "pic-4")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var pic3:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "pic-5")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    func configUI() {
        self.addSubview(PhotoView)
        self.addSubview(NameLabel)
        self.addSubview(TimeLabel)
        self.addSubview(ContentLabel)
        self.addSubview(View1)
        self.addSubview(View2)
       
        
        PhotoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.height.width.equalTo(50)
            make.left.equalToSuperview().offset(30)
        }
        
        NameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(PhotoView.snp.right).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        
        TimeLabel.snp.makeConstraints { make in
            make.top.equalTo(NameLabel.snp.bottom).offset(0)
            make.left.equalTo(NameLabel)
            make.width.equalTo(300)
            make.height.equalTo(20)
        }
        
        ContentLabel.snp.makeConstraints { make in
            make.top.equalTo(TimeLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(50)
        }
        
        View1.snp.makeConstraints { make in
            make.top.equalTo(ContentLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(100)
        }
        
        View2.snp.makeConstraints { make in
            make.top.equalTo(ContentLabel.snp.bottom).offset(5)
            make.left.equalTo(View1.snp.right).offset(10)
            make.width.height.equalTo(100)
        }
        
        
        
    }
    
}
