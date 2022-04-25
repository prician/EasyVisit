//
//  NoteCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/24.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        configUI()
        
    }
    
    lazy var Datelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 23)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.953, green: 0.655, blue: 0.376, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var BlueView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    func configUI() {
        self.addSubview(BlueView)
        self.addSubview(Datelabel)
        
        BlueView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(0)
            make.width.height.equalTo(100)
        }
        
        Datelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.left.equalToSuperview().offset(23)
        }
        
    }
    
}
