//
//  SelfViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/26.
//

import UIKit

class SelfViewController: UIViewController {

    let selfCellID = "selfCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = .white
        configUI()
        // Do any additional setup after loading the view.
    }
    
    
    lazy var headView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "head"))
        imageView.image = UIImage(named: "head")
        imageView.frame = CGRect(x: 0, y: 0, width: Int(screenWidth).fw, height: Int(screenWidth).fh)
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
        
        collectionView.register(SelfCollectionViewCell.self, forCellWithReuseIdentifier: selfCellID)
        return collectionView
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.frame = CGRect(x: 20.fw, y: 50.fh, width: 30.fw, height: 30.fh)
        button.addTarget(self, action: #selector(clickLeftBackButton), for: .allEvents)
        
        return button
    }()
    
    @objc func clickLeftBackButton(){
        tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    func configUI(){
        view.addSubview(headView)
        view.addSubview(collectionView)
        view.addSubview(leftButton)
     
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(10)
            make.height.equalTo(300)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
    }

}

extension  SelfViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selfCellID, for: indexPath) as! SelfCollectionViewCell
        let tit = ["用户名", "年龄", "性别", "所在地", "生日"]
        let ans = ["Prician", "18岁","女", "湖南-株洲-天元区", "8月5日"]
        cell.titleLabel.text = tit[indexPath.row]
        cell.answerLabel.text = ans[indexPath.row]
        return cell
    }


}
    


extension SelfViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: Int(screenWidth - 40).fw, height: 50.fh)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(0.fh), right: CGFloat(0.fw))
//    }
    
    
}

