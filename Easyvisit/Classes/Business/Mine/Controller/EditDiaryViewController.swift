//
//  EditDiaryViewController.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/29.
//

import UIKit
import SnapKit

class EditDiaryViewController: UIViewController {
    
    let date = Date()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = themeColor
        label.font = UIFont(name: "Arial", size: 14)
        label.text = "\(year())年\(month())月\(day())日"
        return label
    }()
    
    lazy var weekLabel: UILabel = {
        let label = UILabel()
        label.textColor = themeColor
        label.font = UIFont(name: "Arial", size: 14)
        label.text = "星期五"
        return label
    }()
    
    lazy var textView: UITextView = {
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
        view.addSubview(weekLabel)
        view.addSubview(textView)
        dateLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20)
            maker.top.equalToSuperview().offset(100)
        }
        weekLabel.snp.makeConstraints { maker in
            maker.right.equalToSuperview().offset(-20)
            maker.top.equalToSuperview().offset(100)
        }
        textView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20)
            maker.top.equalToSuperview().offset(130)
            maker.right.equalToSuperview().offset(-20)
            maker.bottom.equalToSuperview().offset(-100)
        }
    }
    
    func setNav() {
        self.title = "编辑日记"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(submit))
        navigationItem.rightBarButtonItem?.tintColor = themeColor
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func submit() {
        guard let text = textView.text else { return }
        let diary = Diary(content: text, createdAt: getTimeStamp(Date()))
        saveDiary([diary])
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
