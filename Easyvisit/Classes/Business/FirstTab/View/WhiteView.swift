//
//  WhiteView.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/26.
//

import UIKit

class WhiteView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        configUI()
    }
    
    lazy var WhiteView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 14
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var DateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 22)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var NumLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.text = "今日数据"
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var TextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "数据填写"
        tf.backgroundColor = .clear
        tf.textAlignment = .center
        tf.font = UIFont(name: "Arial", size: 12)
        tf.backgroundColor =  UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        return tf
    }()
    
    lazy var RangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.text = "正常范围"
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    lazy var RangeView1: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "range1")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var RangeView2: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "range2")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var RoundLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textAlignment = .left
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var RoundLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textAlignment = .left
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
   
    lazy var LineView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    func configUI() {
        self.addSubview(DateLabel)
        self.addSubview(NumLabel1)
        self.addSubview(TextField)
        self.addSubview(RangeLabel)
        self.addSubview(RangeView1)
        self.addSubview(RangeView2)
        self.addSubview(LineView)
        self.addSubview(RoundLabel1)
        self.addSubview(RoundLabel2)
    
        RoundLabel1.snp.makeConstraints { make in
            make.left.equalTo(RangeView1.snp.right).offset(10)
            make.width.equalTo(100)
            make.top.equalTo(RangeView1)
            make.height.equalTo(RangeView1)
        }
        
        RoundLabel2.snp.makeConstraints { make in
            make.left.equalTo(RangeView2.snp.right).offset(10)
            make.width.equalTo(100)
            make.top.equalTo(RangeView2)
            make.height.equalTo(RangeView2)
        }
        
        DateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(45)
            make.height.equalTo(22)
            make.width.equalTo(100)
        }
        
        NumLabel1.snp.makeConstraints { make in
            make.top.equalTo(DateLabel.snp.bottom).offset(45)
            make.left.equalToSuperview().offset(35)
            make.height.equalTo(18)
            make.width.equalTo(100)
        }
        
        TextField.snp.makeConstraints { make in
            make.top.equalTo(NumLabel1.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(35)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
        
        RangeLabel.snp.makeConstraints { make in
            make.top.equalTo(DateLabel)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(DateLabel)
            make.width.equalTo(DateLabel)
        }
        
        RangeView1.snp.makeConstraints { make in
            make.top.equalTo(RangeLabel.snp.bottom).offset(20)
            make.height.width.equalTo(30)
            make.right.equalTo(RangeLabel).offset(-90)
        }
        
        RangeView2.snp.makeConstraints { make in
            make.top.equalTo(RangeView1.snp.bottom).offset(10)
            make.height.width.equalTo(30)
            make.right.equalTo(RangeView1)
        }
        
        LineView.snp.makeConstraints { make in
            make.top.equalTo(RangeView1).offset(-10)
            make.bottom.equalTo(RangeView2).offset(10)
            make.left.equalTo(DateLabel.snp.right).offset(55)
            make.width.equalTo(2)
        }
        
    }
    
}
