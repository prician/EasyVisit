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
        let searchView = SearchView()
        //searchView.backgroundColor = UIColor(hex: "#FDF5EF")
        searchView.layer.cornerRadius = CGFloat(20.fw)
        //searchView.layer.borderColor = UIColor(hex: "#D8D0C9").cgColor
        searchView.layer.borderWidth = CGFloat(1.fw)
        searchView.searchTextField.delegate = self
        return searchView
    }()
    
    lazy var blackView: UIView = {
        let blv = UIView()
        blv.backgroundColor = .black
        blv.alpha = 0.5
        blv.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(cancleSearch))
        blv.addGestureRecognizer(gesture)
        blv.isHidden = true
        return blv
    }()
    
    @objc func cancleSearch() {
        blackView.isHidden = true
        searchView.searchTextField.resignFirstResponder()
    }
    
    lazy var titleView: PageTitleView = {
        let style = PageStyle()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = true
        style.titleSelectedColor = .white
        style.isShowCoverView = true
        style.titleInset = 10
        let tv = PageTitleView(frame: .zero, style: style, titles: titles)
//        tv.layer.masksToBounds = true
//        tv.coverView.layer.masksToBounds = true
//        tv.clipsToBounds = true
//        tv.coverView.clipsToBounds = true
        return tv
    }()

    lazy var pageViewManager: PageViewManager = {
        let style = PageStyle()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = true
        style.titleSelectedColor = .red
        style.isShowCoverView = true
        style.coverViewHeight = 30
        style.coverViewRadius = 10
        
        let viewControllers = [ChildOneViewController(), ChildTwoViewController()]
        let manager = PageViewManager(style: style, titles: titles, childViewControllers: viewControllers, currentIndex: 0, titleView: titleView, contentView: nil)
//        manager.titleView.layer.masksToBounds = true
//        manager.titleView.clipsToBounds = true
        return manager
    }()

    func configUI() {
        view.addSubview(searchView)
        view.addSubview(pageViewManager.titleView)
        view.addSubview(pageViewManager.contentView)
        
        
        searchView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20.fw)
            maker.right.equalToSuperview().offset(-20.fw)
            maker.height.equalTo(40.fw)
            maker.top.equalToSuperview().offset(120.fh)
        }
        
        pageViewManager.titleView.snp.makeConstraints { maker in
            maker.top.equalTo(searchView.snp.bottom).offset(20)
            maker.right.equalToSuperview().offset(-100)
            maker.left.equalToSuperview().offset(100)
            maker.height.equalTo(60)
        }
        pageViewManager.contentView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(30)
            maker.right.equalToSuperview().offset(-30)
            maker.top.equalTo(pageViewManager.titleView.snp.bottom).offset(30)
            maker.bottom.equalToSuperview().offset(-80)
        }

    }
    

}

extension ReturnVisitViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        blackView.isHidden = false
    }
    
}
