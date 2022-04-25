//
//  MedicineViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/23.
//

import UIKit
import SwiftyJSON

class MedicineViewController: UIViewController {

    let medicineCellID = "medicineCellID"
    var medicineData = [Medicine]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handyJSON()
        configUI()
        self.view.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    lazy var searchView: SearchView = {
        let sv = SearchView()
        sv.backgroundColor = .white
        sv.layer.cornerRadius = CGFloat(20.fw)
        sv.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        sv.layer.borderWidth = CGFloat(1.fw)
        sv.searchTextField.delegate = self
        return sv
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
        
        collectionView.register(MedicineCollectionViewCell.self, forCellWithReuseIdentifier: medicineCellID)
        return collectionView
    }()
    
    lazy var NavLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.frame = CGRect(x: 170.fw, y: 50.fh, width: 200.fw, height: 30.fh)
        label.textAlignment = .left
        label.text = "用药指南"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
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
    
    
    
    func configUI() {
        self.view.addSubview(collectionView)
        self.view.addSubview(leftButton)
        self.view.addSubview(NavLabel)
        self.view.addSubview(searchView)
       
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20.fw)
            make.right.equalToSuperview().offset(-20.fw)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        searchView.snp.makeConstraints{ make in
            make.top.equalTo(NavLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20.fw)
            make.right.equalToSuperview().offset(-20.fw)
            make.height.equalTo(40)
        }
        
    }
    
    func handyJSON() {
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "medicine", ofType: "json")!))
            if let jsonData = String(data: data, encoding: .utf8) {
                let json = JSON(parseJSON: jsonData)
                guard let jsonarray = json.array else {return}
                self.medicineData = jsonarray.map{ json -> Medicine in
                    return Medicine(
                        name: json["name"].stringValue,
                        back: json["back"].stringValue,
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

extension  MedicineViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: medicineCellID, for: indexPath) as! MedicineCollectionViewCell
        cell.NameLabel.text = medicineData[indexPath.section].name
        cell.MediView.image = UIImage(named: medicineData[indexPath.section].back)
        cell.IntroLabel.text = medicineData[indexPath.section].introduce
        return cell
    }

}
    


extension MedicineViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(screenWidth) - 40, height: 135.fh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(20.fh), right: CGFloat(0.fw))
    }
}


extension MedicineViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //blackView.isHidden = false
    }
}
