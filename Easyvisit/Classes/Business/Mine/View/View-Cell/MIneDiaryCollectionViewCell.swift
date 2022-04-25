//
//  MIneDiaryCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/24.
//

import UIKit

class MIneDiaryCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        configUI()
        self.backgroundColor = .clear
    }
    
    
    lazy var WhiteView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.30).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 14
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var diarylabel: UILabel = {
        let label = UILabel()
        label.text = "心情日记心情日记心情日记心情日记心情日记心情日记心情日记心情日记心情日记心情日记心情日记"
        label.frame = CGRect(x: 20, y: 5, width: 100, height: 50)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var cirView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "mine-cir")
        return imageView
    }()
    
    
    func configUI() {
        self.addSubview(WhiteView)
        self.addSubview(cirView)
        WhiteView.addSubview(diarylabel)
        
        WhiteView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10.fw)
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(20.fh)
            make.bottom.equalToSuperview().offset(-20.fh)
        }
        
        diarylabel.snp.makeConstraints { make in
            make.right.left.top.bottom.equalToSuperview()
        }
        
        cirView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(-43)
            make.width.height.equalTo(35)
            make.top.equalToSuperview().offset(15)
        }
        
    }
    
    
    
}
