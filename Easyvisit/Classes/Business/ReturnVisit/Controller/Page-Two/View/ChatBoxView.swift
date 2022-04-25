//
//  ChatBoxView.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/23.
//

import UIKit
import SnapKit

class ChatBoxView: UIView {
    
    lazy var callButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "call"), for: .normal)
        button.addTarget(self, action: #selector(call), for: .touchUpInside)
        return button
    }()
    
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .white
        tv.layer.cornerRadius = 20
        tv.font = UIFont(name: "Arial", size: 18)
        return tv
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapSend), for: .touchUpInside)
        button.setTitle("发送", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 88/255.0, green: 95/255.0, blue: 221/255.0, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    
    @objc func call() {
        let phone = "tel://10086"
        if UIApplication.shared.canOpenURL(URL(string: phone)!) {
            UIApplication.shared.open(URL(string: phone)!, options: [:], completionHandler: nil)
        }
    }
    
    var tapSendHandler: ((String?) -> Void)?
    
    @objc func tapSend() {
        guard let text = textView.text else { return }
        guard text != "" else { return }
        self.tapSendHandler?(text)
    }
    
    var textViewReturnHandler: ((String?) -> Void)?
    
    func setup() {
        self.backgroundColor = .systemGray6
        self.addSubview(callButton)
        self.addSubview(textView)
        self.addSubview(sendButton)
        textView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(10)
            maker.right.equalToSuperview().offset(-100)
            maker.height.equalTo(40)
            maker.left.equalToSuperview().offset(60)
        }
        callButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(10)
            maker.centerY.equalTo(textView)
        }
        sendButton.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-10)
            maker.top.equalToSuperview().offset(10)
            maker.left.equalTo(textView.snp.right).offset(10)
            maker.bottom.equalTo(textView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }

}
