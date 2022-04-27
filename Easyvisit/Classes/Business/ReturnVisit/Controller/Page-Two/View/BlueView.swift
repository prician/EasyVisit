//
//  BlueView.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/27.
//

import UIKit

class BlueView: UIView {

    
    lazy var BlueBack: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        layerView.layer.cornerRadius = 14
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var MedNamelabel: UILabel = {
        let label = UILabel()
        label.text = "阿莫西林"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var Frelabel: UILabel = {
        let label = UILabel()
        label.text = "一日三次"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textColor = .white
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    lazy var TimeLabel1: UILabel = {
        let label = UILabel()
        label.text = "⏰     7:00"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var TimeLabel2: UILabel = {
        let label = UILabel()
        label.text = "13:00"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var TimeLabel3: UILabel = {
        let label = UILabel()
        label.text = "18:00"
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    lazy var BlueBackbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "quxiao"), for: .normal)
        button.addTarget(self, action: #selector(hideBlueBack), for: .touchUpInside)
        return button
    }()
    
    @objc func hideBlueBack(){
        UIView.animate(withDuration: 1, delay: 0, animations: {
            self.transform = CGAffineTransform(translationX: 210, y: 0)
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configUI()
    }
    
    func configUI() {
        self.addSubview(BlueBack)
        BlueBack.addSubview(MedNamelabel)
        BlueBack.addSubview(Frelabel)
        BlueBack.addSubview(TimeLabel1)
        BlueBack.addSubview(TimeLabel2)
        BlueBack.addSubview(TimeLabel3)
        BlueBack.addSubview(BlueBackbutton)
        
        
        BlueBack.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().offset(0)
        }
        
        MedNamelabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(35)
            make.width.equalTo(100)
        }
        Frelabel.snp.makeConstraints { make in
            make.top.equalTo(MedNamelabel)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(100)
        }
        
        TimeLabel1.snp.makeConstraints { make in
            make.top.equalTo(MedNamelabel.snp.bottom).offset(35)
            make.left.equalToSuperview().offset(5)
            make.width.equalTo(80)
        }
        
        TimeLabel2.snp.makeConstraints { make in
            make.top.equalTo(MedNamelabel.snp.bottom).offset(35)
            make.left.equalTo(TimeLabel1.snp.right).offset(8)
            make.right.equalTo(TimeLabel3.snp.left).offset(-5)
        }
        
        TimeLabel3.snp.makeConstraints { make in
            make.top.equalTo(MedNamelabel.snp.bottom).offset(35)
            make.left.equalTo(TimeLabel2.snp.right).offset(20)
            make.right.equalToSuperview().offset(-10)
        }
        
        BlueBackbutton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.right.equalToSuperview().offset(-10)
            make.width.height.equalTo(15)
        }
        
    }

}
