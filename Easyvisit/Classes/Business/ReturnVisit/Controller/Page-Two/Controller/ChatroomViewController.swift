//
//  ChatroomViewController.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/23.
//

import UIKit
import SnapKit
import YYText

class ChatroomViewController: UIViewController {
    
    let chatMessageReuseID = "chatmessage"
    
    var messages: [ChatMessage] = [] {
        didSet {
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: messages.count-1, section: 0), at: .bottom, animated: true)
        }
    }
    
    lazy var chatBoxView: ChatBoxView = {
        let vi = ChatBoxView()
        vi.backgroundColor = .systemGray6
        vi.tapSendHandler = { text in
            self.messages.append(ChatMessage(text: text, uid: 1, time: nil))
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
                self.messages.append(ChatMessage(text: "自动回复【测试】", uid: 0, time: nil))
            })
            vi.textView.text = ""
        }
        return vi
    }()
    
    lazy var hideKeyboardButton: UIButton = {
        let button = UIButton(frame: view.frame)
        button.isHidden = true
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(hideKeyboard), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: chatMessageReuseID)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    @objc func hideKeyboard() {
        self.chatBoxView.textView.resignFirstResponder()
        self.hideKeyboardButton.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(tableView)
        view.addSubview(hideKeyboardButton)
        view.addSubview(chatBoxView)
        chatBoxView.snp.makeConstraints { maker in
            maker.right.left.bottom.equalToSuperview()
            maker.height.equalTo(100)
        }
        tableView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.bottom.equalTo(chatBoxView.snp.top)
            maker.top.equalToSuperview().offset(100)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = .black
        self.title = "医生"
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "call"), style: .done, target: self, action: #selector(call))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 52/255.0, green: 199/255.0, blue: 89/255.0, alpha: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func call() {
        let phone = "tel://10086"
        if UIApplication.shared.canOpenURL(URL(string: phone)!) {
            UIApplication.shared.open(URL(string: phone)!, options: [:], completionHandler: nil)
        }
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillChangeFrame(_ notification: NSNotification) {
        guard let endRect = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect else { return }
        let y = endRect.minY
        if y != screenHeight { self.hideKeyboardButton.isHidden = false }
        chatBoxView.snp.remakeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.bottom.equalTo(view.snp.top).offset(y)
            maker.height.equalTo(y == screenHeight ? 100 : 60)
        }
    }

}

extension ChatroomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: chatMessageReuseID, for: indexPath) as! ChatMessageCell
        let message = messages[indexPath.row]
        cell.direction = message.uid! == 1 ? .FromRightToLeft : .FromLeftToRight
        cell.contentTextLabel.backgroundColor = message.uid == 1 ? .systemBlue : .white
        let textColor: UIColor = message.uid == 1 ? .white : .black
        cell.setContentText(message.text, foregroundColor: textColor)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let text = messages[indexPath.row].text
        let style = NSMutableParagraphStyle()
        style.headIndent = 10
        let attributedString = NSAttributedString(string: text!, attributes: [.paragraphStyle: style, .font: UIFont(name: "Arial", size: 18) as Any])
        let layout = YYTextLayout(containerSize: CGSize(width: screenWidth - 130, height: CGFloat.greatestFiniteMagnitude), text: attributedString)
        return layout!.textBoundingSize.height + 60
    }
    
}
