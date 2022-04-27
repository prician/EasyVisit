//
//  ChildOneViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/23.
//

import UIKit
import SwiftyJSON

class ChildOneViewController: UIViewController {

    let DoctorCellID = "DoctorCellID"
    
    var jumpChatroom: (() -> Void)?
    
    var doctorData: [Doctor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configData()
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
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(DoctorCollectionViewCell.self, forCellWithReuseIdentifier: DoctorCellID)
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
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "doctor", ofType: "json")!))
            guard let jsonString = String(data: data, encoding: .utf8) else { return }
            guard let jsonArray = JSON(parseJSON: jsonString).array else { return }
            doctorData = jsonArray.map { json -> Doctor in
                return Doctor(name: json["name"].stringValue,
                              department: json["department"].stringValue,
                              pho: json["pho"].stringValue,
                              intro: json["intro"].stringValue)
            }
            collectionView.reloadData()
        } catch {
            
        }
    }
    
}

extension  ChildOneViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doctorData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoctorCellID, for: indexPath) as! DoctorCollectionViewCell
        let doctor = doctorData[indexPath.row]
        cell.DoctorNamelabel.text = doctor.name
        cell.DoctorIntrolabel.text = doctor.department + "  " + doctor.intro
        cell.BackView.image = UIImage(named: doctor.pho)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        jumpChatroom?()
    }
}
    


extension ChildOneViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(screenWidth - 40).fw, height: 75.fh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(20.fh), right: CGFloat(0.fw))
    }
}
