//
//  CurveViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/23.
//

import UIKit

class CurveViewController: UIViewController {

    let cureCellID = "cureCellID"
    let pic = ["curve-1", "curve-2", "curve-3", "curve-4"]
    let name = ["血压", "血糖", "体温", "心率"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        configUI()
        // Do any additional setup after loading the view.
    }
    
    lazy var BlueView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        layerView.layer.cornerRadius = 14
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var CirImage:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.image = UIImage(named: "circle")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    lazy var CurLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 22)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "今日健康指数"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
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
        
        collectionView.register(CurveCollectionViewCell.self, forCellWithReuseIdentifier: cureCellID)
        return collectionView
    }()
    
    func configUI() {
        self.view.addSubview(BlueView)
        self.view.addSubview(collectionView)
        BlueView.addSubview(CirImage)
        BlueView.addSubview(dateLabel)
        BlueView.addSubview(CurLabel)
        
        BlueView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130.fh)
            make.right.equalToSuperview().offset(-30.fh)
            make.left.equalToSuperview().offset(30.fw)
            make.height.equalTo(165.fh)
        }
       
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(BlueView.snp.bottom).offset(20.fh)
            make.left.equalToSuperview().offset(20.fw)
            make.right.equalToSuperview().offset(-20.fw)
            make.height.equalTo(600.fh)
        }
        
        CurLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        CirImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-25)
            make.height.width.equalTo(140)
            make.top.equalToSuperview().offset(15)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(CurLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
    }
    
    

}

extension  CurveViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cureCellID, for: indexPath) as! CurveCollectionViewCell
        cell.NameLabel.text = name[indexPath.section]
        cell.BackView.image = UIImage(named: pic[indexPath.section])
        dateLabel.text = cell.DateLabel.text
        cell.layer.cornerRadius = 35
        return cell
    }

}
    


extension CurveViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(screenWidth) - 40, height: 120.fh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(20.fh), right: CGFloat(0.fw))
    }
}
