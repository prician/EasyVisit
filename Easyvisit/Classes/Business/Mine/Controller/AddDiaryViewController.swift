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
    let mo = [0,31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configUI()
        getDateForCacheDiary()
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
    
    lazy var Navlabel:UILabel = {
        let label = UILabel(frame: CGRect(x: screenWidth/2 - 50, y: 50, width: 100, height: 30))
        label.text = "心情日记"
        label.font = UIFont(name: "Arial", size: 18)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
        return label
    }()
    
    func configUI() {
        view.addSubview(bottom)
        view.addSubview(TopcollectionView)
        view.addSubview(direView)
        view.addSubview(leftButton)
        view.addSubview(Navlabel)
        
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
    
    func getDateForCacheDiary() {
        guard let data = getDiary() else { return }
        data.forEach { dia in
            parseTimeStamp(dia.createdAt)
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
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
        var lab = ["\(mon) / \(da)", "\(mon) / \(da-1)", "\(mon) / \(da-2)", "\(mon) / \(da-3)", "\(mon) / \(da-4)"]
        if(day() - 2 == 0)
        {
            lab[2] = "\(mon - 1) / \(mo[mon-1])"
            lab[3] = "\(mon - 1) / \(mo[mon-1] - 1)"
            lab[4] = "\(mon - 1) / \(mo[mon-1] - 2)"
        }
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
