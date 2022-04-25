//
//  CommiteViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/23.
//

import UIKit
import SwiftyJSON

class CommiteViewController: UIViewController {

    let commitCellID = "commitCellID"
    var commitData = [Commit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handyJSON()
        configUI()
        self.view.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
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
            tabBarController?.tabBar.isHidden = false
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
    
    lazy var NavLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.frame = CGRect(x: 170.fw, y: 50.fh, width: 200.fw, height: 30.fh)
        label.textAlignment = .left
        label.text = "用户社区"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    func configUI() {
        self.view.addSubview(collectionView)
        self.view.addSubview(leftButton)
        self.view.addSubview(NavLabel)
       
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(leftButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10.fw)
            make.right.equalToSuperview().offset(-10.fw)
            make.bottom.equalToSuperview().offset(-30)
        }
        
    }
    
    func handyJSON() {
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "commit", ofType: "json")!))
            if let jsonData = String(data: data, encoding: .utf8) {
                let json = JSON(parseJSON: jsonData)
                guard let jsonarray = json.array else {return}
                self.commitData = jsonarray.map{ json -> Commit in
                    return Commit(
                        name: json["name"].stringValue,
                        time: json["time"].stringValue,
                        photo: json["photo"].stringValue,
                        pic1: json["pic1"].stringValue,
                        pic2: json["pic2"].stringValue,
                        introduce: json["introduce"].stringValue
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


extension  CommiteViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commitCellID, for: indexPath) as! CommitCollectionViewCell
        cell.layer.cornerRadius = 35
        cell.PhotoView.image = UIImage(named: self.commitData[indexPath.section].photo)
        cell.NameLabel.text = self.commitData[indexPath.section].name
        cell.View1.image = UIImage(named: self.commitData[indexPath.section].pic1)
        cell.View2.image = UIImage(named: self.commitData[indexPath.section].pic2)
        cell.TimeLabel.text = self.commitData[indexPath.section].time
        cell.ContentLabel.text = self.commitData[indexPath.section].introduce
        return cell
    }

}
    


extension CommiteViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(screenWidth), height: 300.fh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(30.fh), right: CGFloat(0.fw))
    }
}
