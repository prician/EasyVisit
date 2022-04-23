//
//  ReturnVisitViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/21.
//

import UIKit
import DNSPageView
import SnapKit

class ReturnVisitViewController: UIViewController {

    let titles = ["医生", "好友"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configUI()
        
    }

    lazy var searchView: SearchView = {
        let sv = SearchView()
        sv.backgroundColor = .white
        sv.layer.cornerRadius = CGFloat(20.fw)
        sv.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        sv.layer.borderWidth = CGFloat(1.fw)
        sv.searchTextField.delegate = self
        return sv
        }()
    
    lazy var pageManager: PageViewManager = {
        let style = PageStyle()
        style.coverViewAlpha = 1
        style.coverViewBackgroundColor = .blue
        style.isShowCoverView = true
        style.titleSelectedColor = .white
        style.coverViewHeight = 35
        let childrenVC = [ChildOneViewController(), ChildTwoViewController()]
        let manager = PageViewManager(style: style, titles: titles, childViewControllers: childrenVC)
        return manager
    }()
    

    func configUI() {
        view.addSubview(searchView)
        view.addSubview(pageManager.titleView)
        view.addSubview(pageManager.contentView)
        
        searchView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(30.fw)
            make.right.equalToSuperview().offset(-30.fw)
            make.height.equalTo(40)
        }
        
        pageManager.titleView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(30)
            maker.right.equalToSuperview().offset(-30)
            maker.height.equalTo(50)
            maker.top.equalTo(searchView.snp.bottom).offset(20)
        }
        
        pageManager.contentView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(30)
            maker.right.equalToSuperview().offset(-30)
            maker.bottom.equalToSuperview().offset(-70)
            maker.top.equalTo(pageManager.titleView.snp.bottom).offset(25)
        }
        

    }
    

}

extension ReturnVisitViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
}
