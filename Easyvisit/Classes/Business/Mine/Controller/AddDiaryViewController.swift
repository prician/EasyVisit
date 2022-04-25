//
//  AddDiaryViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/23.
//

import UIKit

class AddDiaryViewController: UIViewController {

    let noteCellID = "noteCellID"
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configUI()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.frame = CGRect(x: 20.fw, y: 50.fh, width: 30.fw, height: 30.fh)
        button.addTarget(self, action: #selector(clickLeftBackButton), for: .allEvents)
        
        return button
    }()
    
    @objc func clickLeftBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var TopcollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceVertical = false
        
        collectionView.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: noteCellID)
        return collectionView
    }()
  
    lazy var bottom: BottomView = {
        let bottom = BottomView()
        return bottom
    }()
    
    lazy var direView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dire")
        imageView.clipsToBounds = true
        return imageView
    }()
  
    func configUI() {
        view.addSubview(bottom)
        view.addSubview(TopcollectionView)
        view.addSubview(direView)
        view.addSubview(leftButton)
        
        TopcollectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(80)
            make.height.equalTo(130)
        }
        
        bottom.snp.makeConstraints { make in
            make.left.right.equalToSuperview().offset(0)
            make.top.equalTo(direView.snp.bottom).offset(5)
            make.height.equalTo(screenHeight - 310)
        }
        
        direView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.width.height.equalTo(40)
            make.top.equalTo(TopcollectionView.snp.bottom).offset(0)
        }
        
    }
    
    func month() -> Int {
            let calendar = NSCalendar.current
            let com = calendar.dateComponents([.year, .month, .day], from: date)
            return com.month!
    }
    
    func day() -> Int {
            let calendar = NSCalendar.current
            let com = calendar.dateComponents([.year, .month, .day], from: date)
            return com.day!
    }


}


extension  AddDiaryViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: noteCellID, for: indexPath) as! NoteCollectionViewCell
        let mon = month()
        let da = day()
        let lab = ["\(mon) / \(da)", "\(mon) / \(da-1)", "\(mon) / \(da-2)", "\(mon) / \(da-3)", "\(mon) / \(da-4)"]
        cell.Datelabel.text = lab[indexPath.section]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        NotificationCenter.default.post(name: .init("scroll"), object: indexPath.section * 2)
    }
}
    


extension AddDiaryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.fw, height: 100.fh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(0.fh), right: CGFloat(20.fw))
    }
    
    
}

