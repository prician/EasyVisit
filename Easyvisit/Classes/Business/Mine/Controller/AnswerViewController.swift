//
//  AnswerViewController.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/5/1.
//

import UIKit
import SnapKit
import SwiftyJSON

class AnswerViewController: UIViewController {
    
    var questions: [Question] = []
    
    var currentQuestionIndex: Int = 0 {
        didSet {
            QuestionLabel.text = "\(currentQuestionIndex+1)." + questions[currentQuestionIndex].title
            AnswerALabel.text = questions[currentQuestionIndex].options[0].content
            AnswerBLabel.text = questions[currentQuestionIndex].options[1].content
            AnswerCLabel.text = questions[currentQuestionIndex].options[2].content
            AnswerDLabel.text = questions[currentQuestionIndex].options[3].content
            if selectRecord[currentQuestionIndex] != "" {
                setOptionButtonColor(selectRecord[currentQuestionIndex])
            } else {
                setOptionButtonColor("")
            }
            if currentQuestionIndex == questions.count-1 {
//                nextQuestionButton.setTitle("提交", for: .normal)
                nextQuestionButton.setTitleColor(.systemGray6, for: .normal)
                nextQuestionButton.isEnabled = false
            } else {
//                nextQuestionButton.setTitle("下一题>>", for: .normal)
                nextQuestionButton.setTitleColor(themeColor, for: .normal)
                nextQuestionButton.isEnabled = true
            }
            if currentQuestionIndex == 0 {
                lastQuestionButton.setTitleColor(.systemGray6, for: .normal)
            } else {
                lastQuestionButton.setTitleColor(themeColor, for: .normal)
            }
        }
    }
    
    var selectRecord: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        getQuestions {
            self.ConfigUI()
            self.selectRecord = Array(repeating: "", count: self.questions.count)
        }
        setNav()
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
        let score = getScore()
        saveMoodQ([MoodQ(score: score, createdAt: getTimeStamp(Date()))])
        let alert = UIAlertController(title: "得分", message: "\(score)", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "关闭", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(closeAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    lazy var QuestionLabel: UILabel = {
        let label = UILabel()
        label.text = "1." + (questions.first?.title ?? "")
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 20)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerALabel: UILabel = {
        let label = UILabel()
        label.text = questions.first?.options[0].content
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerBLabel: UILabel = {
        let label = UILabel()
        label.text = questions.first?.options[1].content
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerCLabel: UILabel = {
        let label = UILabel()
        label.text = questions.first?.options[2].content
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var AnswerDLabel: UILabel = {
        let label = UILabel()
        label.text = questions.first?.options[3].content
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    lazy var lastQuestionButton: UIButton = {
        let button = UIButton()
        button.setTitle("<<上一题", for: .normal)
        button.setTitleColor(.systemGray6, for: .normal)
        button.addTarget(self, action: #selector(lastHandler), for: .touchUpInside)
        return button
    }()
    
    lazy var nextQuestionButton: UIButton = {
        let button = UIButton()
        button.setTitle("下一题>>", for: .normal)
        button.setTitleColor(themeColor, for: .normal)
        button.addTarget(self, action: #selector(nextHandler), for: .touchUpInside)
        return button
    }()
    
    @objc func lastHandler() {
        currentQuestionIndex = currentQuestionIndex <= 1 ? 0 : currentQuestionIndex-1
    }
    
    @objc func nextHandler() {
        if currentQuestionIndex == questions.count - 1 {
            let score = getScore()
            let integral = Int(5*score/100.0)
            if let value = UserDefaults.standard.value(forKey: "silkintegral") as? Int {
                UserDefaults.standard.set(value + integral, forKey: "silkintegral")
            } else {
                UserDefaults.standard.set(integral, forKey: "silkintegral")
            }
            let alert = UIAlertController(title: "得分", message: "题目得分：\(score)\n丝绸积分：\(integral)", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "关闭", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(closeAction)
            self.present(alert, animated: true, completion: nil)
        }
        currentQuestionIndex = (currentQuestionIndex >= questions.count-2 ? questions.count-1 : currentQuestionIndex+1)
    }
    
    func getScore() -> Double {
        var score: Double = 0.0
        for i in 0..<selectRecord.count {
            score += questions[i].answer.filter { answer -> Bool in
                return answer.name == selectRecord[i]
            }.first!.score
        }
        return score
    }
    
    lazy var AnswerAView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17.5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = .clear
        button.setTitle("A", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var AnswerBView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17.5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = .clear
        button.setTitle("B", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var AnswerCView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17.5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = .clear
        button.setTitle("C", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var AnswerDView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17.5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = .clear
        button.setTitle("D", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
        return button
    }()
    
    @objc func tapOption(button: UIButton) {
        guard let optionName = button.titleLabel?.text else { return }
        setOptionButtonColor(optionName)
    }
    
    func setOptionButtonColor(_ optionName: String) {
        var bgColors: [UIColor] = [.clear, .clear, .clear, .clear]
        var titleColors: [UIColor] = [.black, .black, .black, .black]
        switch optionName {
        case "A":
            bgColors[0] = themeColor
            titleColors[0] = .white
        case "B":
            bgColors[1] = themeColor
            titleColors[1] = .white
        case "C":
            bgColors[2] = themeColor
            titleColors[2] = .white
        case "D":
            bgColors[3] = themeColor
            titleColors[3] = .white
        default:
            break
        }
        changeOptionButtonColor(AnswerAView, backgroundColor: bgColors[0], titleColor: titleColors[0])
        changeOptionButtonColor(AnswerBView, backgroundColor: bgColors[1], titleColor: titleColors[1])
        changeOptionButtonColor(AnswerCView, backgroundColor: bgColors[2], titleColor: titleColors[2])
        changeOptionButtonColor(AnswerDView, backgroundColor: bgColors[3], titleColor: titleColors[3])
        if optionName != "" { selectRecord[currentQuestionIndex] = optionName }
    }
    
    func changeOptionButtonColor(_ button: UIButton, backgroundColor: UIColor, titleColor: UIColor) {
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
    }
    
    func ConfigUI() {
        self.view.addSubview(QuestionLabel)
        self.view.addSubview(AnswerAView)
        self.view.addSubview(AnswerBView)
        self.view.addSubview(AnswerCView)
        self.view.addSubview(AnswerDView)
        self.view.addSubview(lastQuestionButton)
        self.view.addSubview(nextQuestionButton)
        self.view.addSubview(AnswerALabel)
        self.view.addSubview(AnswerBLabel)
        self.view.addSubview(AnswerCLabel)
        self.view.addSubview(AnswerDLabel)
        
        QuestionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(200)
            make.height.equalTo(100)
        }
        
        AnswerAView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.width.equalTo(35)
            make.top.equalTo(QuestionLabel.snp.bottom).offset(15)
            make.height.equalTo(35)
        }
        
        AnswerBView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.width.equalTo(35)
            make.top.equalTo(AnswerAView.snp.bottom).offset(20)
            make.height.equalTo(35)
        }
        
        AnswerCView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.width.equalTo(35)
            make.top.equalTo(AnswerBView.snp.bottom).offset(20)
            make.height.equalTo(35)
        }
        
        AnswerDView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50)
            make.width.equalTo(35)
            make.top.equalTo(AnswerCView.snp.bottom).offset(20)
            make.height.equalTo(35)
        }
        
        AnswerALabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerAView.snp.right).offset(20)
            make.right.equalToSuperview().offset(-30.fw)
            make.top.equalTo(AnswerAView.snp.top).offset(0)
        }
        
        AnswerBLabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerBView.snp.right).offset(20)
            make.width.equalTo(100)
            make.top.equalTo(AnswerBView.snp.top).offset(0)
            make.right.equalToSuperview().offset(-30.fw)
        }
        
        AnswerCLabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerCView.snp.right).offset(20)
            make.width.equalTo(100)
            make.top.equalTo(AnswerCView.snp.top).offset(0)
            make.right.equalToSuperview().offset(-30.fw)
        }
        
        AnswerDLabel.snp.makeConstraints { make in
            make.left.equalTo(AnswerDView.snp.right).offset(20)
            make.width.equalTo(100)
            make.top.equalTo(AnswerDView.snp.top).offset(0)
            make.right.equalToSuperview().offset(-30.fw)
        }
        
        lastQuestionButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.top.equalTo(AnswerDView.snp.bottom).offset(50)
            make.height.equalTo(50)
        }
        
        nextQuestionButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(100)
            make.top.equalTo(lastQuestionButton).offset(0)
            make.height.equalTo(50)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getQuestions(_ completion: @escaping (() -> Void)) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "question", ofType: "json")!))
            guard let jsonString = String(data: data, encoding: .utf8) else { return }
            guard let jsonArray = JSON(parseJSON: jsonString).array else { return }
            questions = jsonArray.map { json -> Question in
                return Question(
                    title: json["title"].stringValue,
                    options: json["options"].array!.map { json -> Option in
                        return Option(name: json["name"].stringValue, content: json["content"].stringValue)
                    },
                    answer: json["answer"].array!.map { json -> Answer in
                        return Answer(name: json["name"].stringValue, score: json["score"].doubleValue)
                    })
            }
            completion()
        } catch {
            
        }
    }
    
}