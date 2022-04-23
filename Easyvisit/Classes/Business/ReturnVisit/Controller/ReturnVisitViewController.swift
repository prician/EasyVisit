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
    
    lazy var pagerView: PageView = {
        let style = PageStyle()
//        style.isTitleScaleEnabled = true
        //style.isTitleViewScrollEnabled = true
        style.titleViewHeight = 80
        style.coverViewAlpha = 1
        style.coverViewBackgroundColor = .blue
        style.isShowCoverView = true
        style.titleSelectedColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        //style.titleFont = UIFont()
        
        let childrenVC = [ChildOneViewController(), ChildTwoViewController()]
        let pageView = PageView(frame: CGRect(x: 30, y: 140, width: screenWidth - 60, height: 600), style: style, titles: titles, childViewControllers: childrenVC)
        return pageView
    }()
    

    func configUI() {
        view.addSubview(searchView)
        view.addSubview(pagerView)
        
        searchView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(30.fw)
            make.right.equalToSuperview().offset(-30.fw)
            make.height.equalTo(40)
        }
        

    }
    

}

extension ReturnVisitViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
}
