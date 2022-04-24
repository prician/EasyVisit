//
//  CommiteViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/23.
//

import UIKit

class CommiteViewController: UIViewController {

    let commitCellID = "commitCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        self.view.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceVertical = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(CommitCollectionViewCell.self, forCellWithReuseIdentifier: commitCellID)
        return collectionView
    }()
    

    func configUI() {
        self.view.addSubview(collectionView)
       
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50.fh)
            make.left.equalToSuperview().offset(10.fw)
            make.right.equalToSuperview().offset(-10.fw)
            make.height.equalTo(screenHeight)
        }
        
        
    }
    
}


extension  CommiteViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commitCellID, for: indexPath) as! CommitCollectionViewCell
        cell.layer.cornerRadius = 35
        return cell
    }

}
    


extension CommiteViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(screenWidth), height: 250.fh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(30.fh), right: CGFloat(0.fw))
    }
}
