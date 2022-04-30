//
//  CaseViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/26.
//

import UIKit
import SwiftyJSON

class CaseViewController: UIViewController {

    var caseData = [Case]()
    let caseCellID = "caseCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        handyJSON()
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = .white
        configUI()
    }
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = true // 隐藏滑动条
        collectionView.alwaysBounceVertical = false
        
        collectionView.register(CaseCollectionViewCell.self, forCellWithReuseIdentifier: caseCellID)
        return collectionView
    }()
    
    func setNav() {
        self.title = "我的病历"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "添加", style: .done, target: self, action: #selector(submit))
        navigationItem.rightBarButtonItem?.tintColor = themeColor
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func submit() {
        let vc = EditCaseViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configUI(){
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(110)
            make.bottom.equalToSuperview().offset(-80)
            make.left.right.equalToSuperview().offset(0)
        }
        
    }
    
    func handyJSON() {
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "case", ofType: "json")!))
            if let jsonData = String(data: data, encoding: .utf8) {
                let json = JSON(parseJSON: jsonData)
                guard let jsonarray = json.array else {return}
                self.caseData = jsonarray.map{ json -> Case in
                    return Case(
                        reason: json["reason"].stringValue,
                        doctor: json["doctor"].stringValue,
                        intro: json["intro"].stringValue
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

extension  CaseViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: caseCellID, for: indexPath) as! CaseCollectionViewCell
        cell.layer.cornerRadius = 20
//        cell.DoctorLabel.text = self.caseData[indexPath.row].doctor
//        cell.IntroLabel.text = self.caseData[indexPath.row].intro
//        cell.reansonLabel.text = self.caseData[indexPath.row].reason
        return cell
    }


}
    


extension CaseViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: Int(screenWidth - 40).fw, height: 250.fh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(25.fh), right: CGFloat(0.fw))
    }
    
    
}

