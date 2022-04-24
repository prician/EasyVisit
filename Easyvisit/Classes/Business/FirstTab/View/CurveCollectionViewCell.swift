//
//  CurveCollectionViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/24.
//

import UIKit

class CurveCollectionViewCell: UICollectionViewCell {
 
    let date = Date()
    
    override func layoutSubviews() {
        configUI()
        self.backgroundColor = .white
    }
    
    
    func year() -> Int {
            let calendar = NSCalendar.current
            let com = calendar.dateComponents([.year, .month, .day], from: date)
            return com.year!
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
    
    func daysInCurrMonth() -> Int {
            let days: NSRange = (Calendar.current as NSCalendar).range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date)
            return days.length
    }
    
    
    lazy var BackView:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var CureView:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "curve-5")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var NameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 20)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    
    lazy var DateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 15)
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0
        label.text = "\(month()) 月 \(day()) 日"
        return label
    }()
    
    
    
    func configUI() {
        self.addSubview(BackView)
        self.addSubview(NameLabel)
        self.addSubview(DateLabel)
        self.addSubview(CureView)
       
        NameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(20.fw)
            make.width.equalTo(80)
        }
        
        DateLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20.fw)
            make.height.equalTo(40)
        }
        
        BackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32.fh)
            make.left.equalTo(NameLabel.snp.right).offset(5)
            make.width.height.equalTo(30)
        }
        
        CureView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(80)
            make.width.equalTo(120)
            make.right.equalToSuperview().offset(-20)
        }
        
    }
    
    
    
    
}
