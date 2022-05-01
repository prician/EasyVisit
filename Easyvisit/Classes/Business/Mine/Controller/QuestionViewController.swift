//
//  QuestionViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/5/1.
//

import UIKit

class QuestionViewController: UIViewController {

    var questionData = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setNav()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    func setNav() {
        self.title = "心情问卷"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(submit))
        navigationItem.rightBarButtonItem?.tintColor = themeColor
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func submit() {
        
    }
    
}
