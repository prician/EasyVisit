//
//  NoticeView.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/22.
//

import UIKit

class NoticeView: UIView {

    let NoticeCellID = "NoticeCellID"
    let time = ["14:30", "每日三次，每次一片", "18:00"]
    let name = ["今日回访", "今日吃药", "今日核酸"]
    let pic = ["notice-1", "notice-2", "notice-3"]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configUI()
    }

    lazy var DatecollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceVertical = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(NoticeCollectionViewCell.self, forCellWithReuseIdentifier: NoticeCellID)
        return collectionView
    }()
    
    func configUI() {
        self.addSubview(DatecollectionView)
        
        DatecollectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview().offset(0)
            
        }
        
        
    }
    
}

extension  NoticeView:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoticeCellID, for: indexPath) as! NoticeCollectionViewCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.nameLabel.text = name[indexPath.section]
        cell.timeLabel.text = time[indexPath.section]
        cell.leftView.image = UIImage(named: pic[indexPath.section])
        cell.descLabel.text = "描述描述描述"
        cell.bottomView.backgroundColor = UIColor(red: 122/255.0, green: 127/255.0, blue: 225/255.0, alpha: 1)
        cell.WhiteView.backgroundColor = UIColor(red: 88/255.0, green: 95/255.0, blue: 221/255.0, alpha: 1)
        cell.dateLabel.text = "日期日期"
        cell.dateImageView.image = UIImage(named: "date")
        cell.timeImageView.image = UIImage(named: "time")
        return cell
    }

}
    


extension NoticeView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360.fw, height: 150.fh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(10.fh), right: CGFloat(0.fw))
    }
}
