//
//  EditRecordViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/30.
//

import UIKit

class EditRecordViewController: UIViewController {

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
    
    lazy var hosTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "Arial", size: 18)
        return tv
    }()
    
    lazy var hoslabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textAlignment = .left
        label.text = "请输入就医医院"
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
    
    lazy var depTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "Arial", size: 18)
        return tv
    }()
    
    lazy var deplabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textAlignment = .left
        label.text = "请输入就医科室"
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
    
    lazy var timeTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "Arial", size: 18)
        return tv
    }()
    
    lazy var timelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textAlignment = .left
        label.text = "请输入就医时间"
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
        WhiteView1.addSubview(hoslabel)
        WhiteView1.addSubview(hosTextView)
        view.addSubview(WhiteView2)
        WhiteView2.addSubview(deplabel)
        WhiteView2.addSubview(depTextView)
        view.addSubview(WhiteView3)
        WhiteView3.addSubview(timelabel)
        WhiteView3.addSubview(timeTextView)
        
        dateLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20)
            maker.top.equalToSuperview().offset(100)
        }
        
        WhiteView1.snp.makeConstraints{ make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.height.equalTo(100)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        hoslabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(25)
        }
        
        hosTextView.snp.makeConstraints { make in
            make.top.equalTo(hoslabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        WhiteView2.snp.makeConstraints{ make in
            make.top.equalTo(WhiteView1.snp.bottom).offset(20)
            make.height.equalTo(100)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        deplabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        depTextView.snp.makeConstraints { make in
            make.top.equalTo(deplabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        WhiteView3.snp.makeConstraints{ make in
            make.top.equalTo(WhiteView2.snp.bottom).offset(20)
            make.height.equalTo(100)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        timelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        timeTextView.snp.makeConstraints { make in
            make.top.equalTo(timelabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        
    }
    
    func setNav() {
        self.title = "编辑就医记录"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(submit))
        navigationItem.rightBarButtonItem?.tintColor = themeColor
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func submit() {
        guard let name = hosTextView.text else { return }
        guard let depar = depTextView.text else { return }
        guard let time = timeTextView.text else { return }
        let department = Department(name: name, depar: depar, time: time, createdAt: getTimeStamp(Date()))
        saveHospitalRecord([department])
        print(getDepartment())
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
