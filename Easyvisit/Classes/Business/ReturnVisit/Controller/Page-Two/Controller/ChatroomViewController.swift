//
//  ChatroomViewController.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/23.
//

import UIKit
import SnapKit
import YYText
import DNSPageView
import SocketIO

class ChatroomViewController: UIViewController {
    
    let chatMessageReuseID = "chatmessage"
    
    var doctor: Doctor!
    var friend: Friend!
    var objectType: ChatObjectType!
    
    enum ChatObjectType {
        case doctor
        case friend
    }
    
    init(_ doctor: Doctor) {
        super.init(nibName: nil, bundle: nil)
        
        self.doctor = doctor
        objectType = .doctor
    }
    
    init(_ friend: Friend) {
        super.init(nibName: nil, bundle: nil)
        
        self.friend = friend
        objectType = .friend
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            print(getTimeStamp(Date()))
            let message = ChatMessage(text: text, uid: 1, time: Int(Float(getTimeStamp(Date())) ?? 0.0))
            self.messages.append(message)
            saveChatHistory([message])
            self.sendMessage(message)
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
    
    lazy var pageViewManager: PageViewManager = {
        let style = PageStyle()
        let titles = ["病例", "心情"]
        let manager = PageViewManager(style: style, titles: titles, childViewControllers: [CaseViewController_2(), UIViewController()])
        return manager
    }()
    
    lazy var pageViewContainer: UIView = {
        let vi = UIView()
        vi.layer.borderColor = UIColor.systemGray6.cgColor
        vi.layer.borderWidth = 1
        vi.layer.cornerRadius = 20
        vi.layer.masksToBounds = true
        vi.backgroundColor = .white
        vi.addSubview(pageViewManager.titleView)
        vi.addSubview(pageViewManager.contentView)
        pageViewManager.titleView.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.width.equalTo(100)
            maker.height.equalTo(40)
        }
        pageViewManager.contentView.snp.makeConstraints { maker in
            maker.left.right.bottom.equalToSuperview()
            maker.top.equalTo(pageViewManager.titleView.snp.bottom)
        }
        return vi
    }()
    
    lazy var BlueView: BlueView = {
        let blueview = Easyvisit.BlueView()
        return blueview
    }()
    
    
    @objc func hideKeyboard() {
        self.chatBoxView.textView.resignFirstResponder()
        self.hideKeyboardButton.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        joinRoom()
    }

    //socket断开连接处理
    var disconnectHandler: (() -> Void) = {}
    
    //加入房间成功处理
    lazy var joinRoomSuccessHandler: NormalCallback = { data, _ in
        LTXLogger.shared.log("加入房间成功")
        self.configChatHistory()
    }

    var oppositeID = 522
    
    func setUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(tableView)
        view.addSubview(hideKeyboardButton)
        view.addSubview(chatBoxView)
        view.addSubview(BlueView)
        
        chatBoxView.snp.makeConstraints { maker in
            maker.right.left.bottom.equalToSuperview()
            maker.height.equalTo(100)
        }
        tableView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.bottom.equalTo(chatBoxView.snp.top)
            maker.top.equalToSuperview().offset(300)
        }
        view.addSubview(pageViewContainer)
        pageViewContainer.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(100)
            maker.width.equalTo(300)
            maker.height.equalTo(150)
        }
        
        BlueView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(660)
            make.width.equalTo(200)
            make.height.equalTo(150)
            make.right.equalToSuperview().offset(210)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNav()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func configChatHistory() {
        guard let data = getChatHistory() else { return }
        self.messages = data
    }
    
    func setNav() {
        self.navigationController?.navigationBar.tintColor = .black
        self.title = "医生"
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "用药提醒", style: .done, target: self, action: #selector(medicationReminder))]
        self.navigationItem.rightBarButtonItems?.forEach { item in
            item.tintColor = UIColor(red: 88/255.0, green: 95/255.0, blue: 221/255.0, alpha: 1)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .done, target: self, action: #selector(back))
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 88/255.0, green: 95/255.0, blue: 221/255.0, alpha: 1)
        }
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func medicationReminder() {
        UIView.animate(withDuration: 1, delay: 0, animations: {
            self.BlueView.transform = CGAffineTransform(translationX: -220, y: 0)
        })
    }
    
    @objc func tapIndex() {
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
        cell.setAvatarImage(message.uid! == 1 ? UIImage(named: "avatar") : (objectType == .doctor ? UIImage(named: doctor.pho) : UIImage(named: friend.photo)))
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

extension ChatroomViewController {
    
    func createLabel(_ text: String?) -> UILabel {
        let label = UILabel()
        label.frame.size = CGSize(width: 46, height: 46)
        label.text = text
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 23
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        label.backgroundColor = UIColor(red: 88/255.0, green: 95/255.0, blue: 221/255.0, alpha: 1)
        return label
    }
    
}

//socket相关方法
extension ChatroomViewController {
    
    //加入房间
    func joinRoom() {
        guard let roomName = getRoomName() else {
            LTXLogger.shared.log("获取房间名字失败")
            return
        }
        socket.emit("join", with: [roomName])
        socket.on("joinsuccess", callback: joinRoomSuccessHandler)
    }
    
    //发送消息
    func sendMessage(_ message: ChatMessage) {
        guard let messageJSON = message.toJSON() else { return }
        do {
            let messageData = try JSONSerialization.data(withJSONObject: messageJSON, options: [])
            guard let messageJSONString = String(data: messageData, encoding: .utf8) else { return }
            socket.emit("send", with: [[
                "room": getRoomName()!,
                "message": messageJSONString
            ]])
        } catch {
            
        }
    }
    
    //获取房间名字
    func getRoomName() -> String? {
        guard let uid = UserDefaults.standard.value(forKey: "uid") as? Int else { return nil }
        let roomName = uid >= oppositeID ? "\(oppositeID)_\(uid)" : "\(uid)_\(oppositeID)"
        return roomName
    }
    
}
