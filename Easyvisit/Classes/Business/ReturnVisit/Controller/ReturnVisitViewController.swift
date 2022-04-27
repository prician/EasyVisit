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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }

    lazy var searchView: SearchView = {
        let sv = SearchView()
        sv.backgroundColor = .white
        sv.layer.cornerRadius = CGFloat(20.fw)
        sv.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        sv.layer.borderWidth = CGFloat(1.fw)
        return sv
        }()
    
    lazy var pageManager: PageViewManager = {
        let style = PageStyle()
        style.coverViewAlpha = 1
        style.coverViewBackgroundColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        style.isShowCoverView = true
        style.titleSelectedColor = .white
        style.coverViewHeight = 35
        style.coverViewRadius = 15
        let vc1 = ChildOneViewController()
        let vc2 = ChildTwoViewController()
        vc1.jumpChatroom = { doctor in
            self.navigationController?.pushViewController(ChatroomViewController(doctor), animated: true)
        }
        vc2.jumpChatroom = { friend in
            self.navigationController?.pushViewController(ChatroomViewController(friend), animated: true)
        }
        let childrenVC = [vc1, vc2]
        let manager = PageViewManager(style: style, titles: titles, childViewControllers: childrenVC)
        manager.titleView.layer.borderColor = UIColor.systemGray6.cgColor
        manager.titleView.layer.borderWidth = 1
        manager.titleView.layer.cornerRadius = 15
        return manager
    }()
    
    lazy var blackView: UIView = {
        let vi = UIView(frame: view.frame)
        vi.backgroundColor = .black
        vi.alpha = 0.5
        vi.isHidden = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapBlackView))
        vi.addGestureRecognizer(gesture)
        return vi
    }()
    
    @objc func tapBlackView() {
        searchView.searchTextField.resignFirstResponder()
        blackView.isHidden = true
    }

    func configUI() {
        view.addSubview(pageManager.titleView)
        view.addSubview(pageManager.contentView)
        view.addSubview(blackView)
        view.addSubview(searchView)
        
        searchView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(30.fw)
            make.right.equalToSuperview().offset(-30.fw)
            make.height.equalTo(40)
        }
        
        pageManager.titleView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.width.equalTo(200)
            maker.height.equalTo(35)
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
        blackView.isHidden = false
    }
    
}
