//
//  CaseCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/26.
//

import UIKit

class CaseCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        configUI()
        
    }
    
    lazy var WhiteView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.30).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var BlueView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.30).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        //layerView.layer. = 20
        layerView.backgroundColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var NameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "林女士    ｜    女    ｜    18岁"
        label.textColor = .white
        return label
    }()
    
    
    lazy var reansonLabel: UILabel = { //入院诊断
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "入院诊断入院诊断入院诊断入院诊断入院诊断"
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    lazy var DoctorLabel: UILabel = { //主治医生
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "主治医生"
        label.textColor = .black
        return label
    }()
    
    lazy var IntroLabel: UILabel = { //医嘱
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "医嘱医嘱医嘱医嘱医嘱医嘱医嘱医嘱医嘱医嘱医嘱医嘱医嘱医嘱医嘱医嘱医嘱医嘱"
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var DateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "2022-4-27"
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    func configUI() {
        self.addSubview(WhiteView)
        WhiteView.addSubview(BlueView)
        BlueView.addSubview(NameLabel)
        BlueView.addSubview(DateLabel)
        BlueView.addSubview(reansonLabel)
        WhiteView.addSubview(DoctorLabel)
        WhiteView.addSubview(IntroLabel)
        
        WhiteView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        BlueView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().offset(0)
            make.height.equalTo(80)
        }
        
        NameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(200)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
        
        DateLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-25)
            make.width.equalTo(100)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
        
        reansonLabel.snp.makeConstraints { make in
            make.left.equalTo(NameLabel)
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(NameLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        IntroLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalTo(DoctorLabel.snp.bottom).offset(-5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        DoctorLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(80)
            make.height.equalTo(30)
            
        }
        
        
    }
    
    
}
