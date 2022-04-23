//
//  FirstCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/22.
//

import UIKit
import SnapKit

class FirstCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        configUI()
        self.backgroundColor = .white
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

    
    lazy var BackView:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        //imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    lazy var IntroduceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 10)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    func configUI() {
        self.addSubview(WhiteView)
        WhiteView.addSubview(BackView)
        WhiteView.addSubview(IntroduceLabel)
        
        WhiteView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5.fh)
            make.right.equalToSuperview().offset(-5.fh)
            make.left.equalToSuperview().offset(5.fw)
            make.bottom.equalToSuperview().offset(-5)
        }
       
        BackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5.fh)
            make.left.equalToSuperview().offset(17.fw)
            make.width.height.equalTo(30)
        }
        
        IntroduceLabel.snp.makeConstraints { make in
            make.top.equalTo(BackView.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-5.fh)
            make.left.equalToSuperview().offset(10.fw)
            make.right.equalToSuperview().offset(-10.fw)
        }
        
    }
    
}
