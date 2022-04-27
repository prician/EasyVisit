//
//  ChildOneViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/23.
//

import UIKit
import SwiftyJSON

class ChildTwoViewController: UIViewController {

    var friendData = [Friend]()
    let FirCellID = "FirCellID"
    
    var jumpChatroom: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configData()
        configUI()
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: FirCellID)
        return collectionView
    }()

    func configUI() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints{ make in
            make.top.left.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
        }
   

    }
    
    func configData() {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "friend", ofType: "json")!))
            guard let jsonString = String(data: data, encoding: .utf8) else { return }
            guard let jsonArray = JSON(parseJSON: jsonString).array else { return }
            friendData = jsonArray.map { json -> Friend in
                return Friend(name: json["name"].stringValue,
                              photo: json["photo"].stringValue,
                              intro: json["intro"].stringValue)
            }
            collectionView.reloadData()
        } catch {
            
        }
    }
    
    
}

extension  ChildTwoViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirCellID, for: indexPath) as! FriendCollectionViewCell
        cell.BackView.image = UIImage(named: self.friendData[indexPath.section].photo)
        cell.FriNamelabel.text = self.friendData[indexPath.section].name
        cell.FriIntrolabel.text = self.friendData[indexPath.section].intro
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        jumpChatroom?()
    }
}
    


extension ChildTwoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(screenWidth - 40).fw, height: 75.fh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(20.fh), right: CGFloat(0.fw))
    }
    
}
