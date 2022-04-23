//
//  MineViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/21.
//

import UIKit

class MineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configUI()
        // Do any additional setup after loading the view.
    }
    
    lazy var topView: TopView = {
        let topView = TopView()
        return topView
    }()
    
    func configUI() {
        view.addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().offset(0)
        }
        
    }
    

}
