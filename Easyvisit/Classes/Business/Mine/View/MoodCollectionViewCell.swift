//
//  MoodCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/23.
//

import UIKit

class MoodCollectionViewCell: UICollectionViewCell {
    
    var AddcellCallBack: ((String) -> Void)?
    var OtnercellCallBack: ((String) -> Void)?
    
    let moodcellCellID = "moodcellCellID"
    let pic = ["mood1", "mood2", "mood3", "mood3"]
    
    override func layoutSubviews() {
        configUI()
        
    }
    
    lazy var diarylabel: UILabel = {
        let label = UILabel()
        label.text = "心情日记"
        label.frame = CGRect(x: 20, y: 5, width: 100, height: 50)
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = UIColor(red: 0.353, green: 0.358, blue: 0.367, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var diaryView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        //imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceVertical = false
        
        collectionView.register(MoodCellCollectionViewCell.self, forCellWithReuseIdentifier: moodcellCellID)
        return collectionView
    }()
    
    
    func configUI() {
        self.addSubview(diarylabel)
        self.addSubview(collectionView)
        self.addSubview(diaryView)
        
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
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50.fh)
            make.bottom.equalToSuperview().offset(0.fh)
            make.left.equalToSuperview().offset(0.fw)
            make.right.equalToSuperview().offset(0.fw)
        }
        
    }
    
}

extension  MoodCollectionViewCell:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moodcellCellID, for: indexPath) as! MoodCellCollectionViewCell
        cell.clipsToBounds = true
        cell.imageView.image = UIImage(named: pic[indexPath.section])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section{
        case 0:
            if let callback = AddcellCallBack {
                callback("123")
            }
            break
        default:
            if let callback = OtnercellCallBack {
                callback("123")
            }
        }
    }
}
    


extension MoodCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110.fw, height: 150.fh)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(0.fh), right: CGFloat(15.fw))
    }
    
}
