//
//  EditDiaryViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/30.
//

import UIKit
import SnapKit

class EditCaseViewController: UIViewController {
    
    
    let date = Date()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = themeColor
        label.font = UIFont(name: "Arial", size: 14)
        label.text = "\(year())年\(month())月\(day())日"
        return label
    }()
    
    lazy var WhiteView1: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.30).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 15
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var reasonTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "Arial", size: 18)
        return tv
    }()
    
    lazy var reasonlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textAlignment = .left
        label.text = "请输入入院诊断"
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var WhiteView2: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.30).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 15
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var doctorTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "Arial", size: 18)
        return tv
    }()
    
    lazy var doctorlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textAlignment = .left
        label.text = "请输入主治医生"
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var WhiteView3: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.30).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 15
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var introTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "Arial", size: 18)
        return tv
    }()
    
    lazy var introlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textAlignment = .left
        label.text = "请输入出院诊断或注意事项"
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var createdAtTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "Arial", size: 18)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUI()
        setNav()
    }
    
    func setUI() {
        view.backgroundColor = .white
        view.addSubview(dateLabel)
        view.addSubview(WhiteView1)
        WhiteView1.addSubview(reasonlabel)
        WhiteView1.addSubview(reasonTextView)
        view.addSubview(WhiteView2)
        WhiteView2.addSubview(doctorlabel)
        WhiteView2.addSubview(doctorTextView)
        view.addSubview(WhiteView3)
        WhiteView3.addSubview(introlabel)
        WhiteView3.addSubview(introTextView)
        
        dateLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20)
            maker.top.equalToSuperview().offset(100)
        }
        
        WhiteView1.snp.makeConstraints{ make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.height.equalTo(150)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        reasonlabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(25)
        }
        
        reasonTextView.snp.makeConstraints { make in
            make.top.equalTo(reasonlabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        WhiteView2.snp.makeConstraints{ make in
            make.top.equalTo(WhiteView1.snp.bottom).offset(20)
            make.height.equalTo(80)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        doctorlabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        doctorTextView.snp.makeConstraints { make in
            make.top.equalTo(doctorlabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        WhiteView3.snp.makeConstraints{ make in
            make.top.equalTo(WhiteView2.snp.bottom).offset(20)
            make.height.equalTo(150)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        introlabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        introTextView.snp.makeConstraints { make in
            make.top.equalTo(introlabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        
    }
    
    func setNav() {
        self.title = "编辑病历"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(submit))
        navigationItem.rightBarButtonItem?.tintColor = themeColor
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func submit() {
        guard let text1 = reasonTextView.text else { return }
        guard let text2 = doctorTextView.text else { return }
        guard let text3 = introTextView.text else { return }
        let cases = Case(reason: text1, doctor: text2, intro: text3, createdAt: getTimeStamp(Date()))
        saveCase([cases])
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
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

}
