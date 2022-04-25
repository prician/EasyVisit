//
//  BottomView.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/24.
//

import UIKit
import SwiftyJSON

class BottomView: UIView {

    let bottomCellID = "bottomCellID"
    var diaryData = [Diary]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        handyJSON()
        configUI()
        self.backgroundColor = .clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(scroll), name: .init("scroll"), object: nil)
    }
    
    @objc func scroll(notification: NSNotification) {
        guard let object = notification.object as? Int else { return }
        print(object)
        BottomcollectionView.scrollToItem(at: IndexPath(row: 0, section: object), at: .top, animated: true)
    }
    
    lazy var LineView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var BottomcollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceVertical = false
        
        collectionView.register(MIneDiaryCollectionViewCell.self, forCellWithReuseIdentifier: bottomCellID)
        return collectionView
    }()
    
    
    func configUI() {
        self.addSubview(LineView)
        self.addSubview(BottomcollectionView)
        
        BottomcollectionView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(-40)
            make.height.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        LineView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(65)
            make.width.equalTo(2)
            make.top.equalToSuperview().offset(0)
            make.height.equalToSuperview()
        }
    }
    
    func handyJSON() {
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "diary", ofType: "json")!))
            if let jsonData = String(data: data, encoding: .utf8) {
                let json = JSON(parseJSON: jsonData)
                guard let jsonarray = json.array else {return}
                self.diaryData = jsonarray.map{ json -> Diary in
                    return Diary(
                        content: json["content"].stringValue
                    )
                }
                
            }
            else {print("false")}
        }
        catch{
            print("false")
            
        }
    }
    
    
}


extension  BottomView:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bottomCellID, for: indexPath) as! MIneDiaryCollectionViewCell
        cell.diarylabel.text = self.diaryData[indexPath.section].content
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }
}
    


extension BottomView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 285, height: 180.fh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(40.fh), right: CGFloat(0.fw))
    }
    
    
}
