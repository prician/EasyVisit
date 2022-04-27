//
//  CaseViewController.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/25.
//

import UIKit

class CaseViewController_2: UIViewController {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
//        let attributedString = NSMutableAttributedString(string: "姓名: 某某某", attributes: [.font: UIFont(name: "Arial", size: 15)])
//        attributedString.setAttributes([.foregroundColor: UIColor(red: 88/255.0, green: 95/255.0, blue: 221/255.0, alpha: 1)], range: NSRange(location: 0, length: 3))
//        label.attributedText = attributedString
        label.text = "姓名: 某某某"
        label.font = UIFont(name: "Arial", size: 15)
        return label
    }()
    
    lazy var sexLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "性别: 男"
        label.font = UIFont(name: "Arial", size: 15)
        return label
    }()
    
    lazy var beHospitalizedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "入院诊断: 某某某"
        label.font = UIFont(name: "Arial", size: 15)
        return label
    }()
    
    lazy var leaveHospitalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "出院诊断: 某某某"
        label.font = UIFont(name: "Arial", size: 15)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI() {
        view.addSubview(nameLabel)
        view.addSubview(sexLabel)
        view.addSubview(beHospitalizedLabel)
        view.addSubview(leaveHospitalLabel)
        nameLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview()
            maker.top.equalToSuperview().offset(10)
            maker.right.equalTo(view.snp.centerX)
        }
        sexLabel.snp.makeConstraints { maker in
            maker.top.equalTo(nameLabel)
            maker.left.equalTo(view.snp.centerX)
            maker.right.equalToSuperview()
        }
        beHospitalizedLabel.snp.makeConstraints { maker in
            maker.top.equalTo(nameLabel.snp.bottom).offset(40)
            maker.left.equalToSuperview()
            maker.right.equalTo(view.snp.centerX)
        }
        leaveHospitalLabel.snp.makeConstraints { maker in
            maker.top.equalTo(sexLabel.snp.bottom).offset(40)
            maker.right.equalToSuperview()
            maker.left.equalTo(view.snp.centerX)
        }
    }

}
