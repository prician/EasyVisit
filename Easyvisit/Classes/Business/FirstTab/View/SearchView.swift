//
//  SearchView.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/22.
//

import UIKit
import SnapKit

class SearchView: UIView {

    lazy var searchImageView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "search")
        return imgV
    }()
    
    lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search"
        tf.backgroundColor = .clear
        tf.font = UIFont(name: "Arial", size: 15)
        return tf
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        self.addSubview(searchImageView)
        self.addSubview(searchTextField)
        
        searchImageView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.width.height.equalTo(25.fw)
            maker.left.equalToSuperview().offset(10.fw)
        }
        searchTextField.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.height.equalTo(30.fw)
            maker.left.equalTo(searchImageView.snp.right).offset(15)
            maker.right.equalToSuperview().offset(-30.fw)
        }
    }


}
