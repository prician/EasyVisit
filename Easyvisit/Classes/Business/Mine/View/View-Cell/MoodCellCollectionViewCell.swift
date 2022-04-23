//
//  MoodCellCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/23.
//

import UIKit

class MoodCellCollectionViewCell: UICollectionViewCell {
    
    
    override func layoutSubviews() {
        configUI()
        
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    func configUI() {
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.right.left.top.bottom.equalToSuperview().offset(0)
            
        }
    }
    
}
