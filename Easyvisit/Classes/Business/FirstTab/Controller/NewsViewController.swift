//
//  NewsViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/27.
//

import UIKit
import SwiftyJSON

class NewsViewController: UIViewController {

    var cnt: Int = 0
    var newsData = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handyJSON()
        configUI()
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    lazy var leftButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "back"), for: .normal)
            button.frame = CGRect(x: 20.fw, y: 50.fh, width: 30.fw, height: 30.fh)
            button.addTarget(self, action: #selector(clickLeftBackButton), for: .allEvents)
            
            return button
        }()
        
    @objc func clickLeftBackButton(){
        self.navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
    

    lazy var WhiteView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.30).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 30
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var TitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 26)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var IntroLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 16)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.279, green: 0.275, blue: 0.275, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var IntroLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 16)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.279, green: 0.275, blue: 0.275, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var IntroLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 16)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.279, green: 0.275, blue: 0.275, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var BackImage:UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.image = UIImage(named: "news_back")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    func configUI() {
        view.backgroundColor = .white
        view.addSubview(BackImage)
        view.addSubview(WhiteView)
        view.addSubview(leftButton)
        WhiteView.addSubview(TitleLabel)
        WhiteView.addSubview(IntroLabel1)
        WhiteView.addSubview(IntroLabel2)
        WhiteView.addSubview(IntroLabel3)
        
        BackImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().offset(0)
            make.height.equalTo(screenWidth - 200)
        }
        
        WhiteView.snp.makeConstraints { make in
            make.top.equalTo(BackImage.snp.bottom).offset(-10)
            make.left.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
        
        TitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        IntroLabel1.snp.makeConstraints { make in
            make.top.equalTo(TitleLabel.snp.bottom).offset(35)
            //make.height.equalToSuperview()
            make.left.equalTo(TitleLabel)
            make.right.equalTo(TitleLabel)
        }
        
        IntroLabel2.snp.makeConstraints { make in
            make.top.equalTo(IntroLabel1.snp.bottom).offset(5)
            //make.height.equalToSuperview()
            make.left.equalTo(TitleLabel)
            make.right.equalTo(TitleLabel)
        }
        
        IntroLabel3.snp.makeConstraints { make in
            make.top.equalTo(IntroLabel2.snp.bottom).offset(5)
            //make.height.equalToSuperview()
            make.left.equalTo(TitleLabel)
            make.right.equalTo(TitleLabel)
        }
        
    }
    
    func handyJSON() {
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "news", ofType: "json")!))
            if let jsonData = String(data: data, encoding: .utf8) {
                let json = JSON(parseJSON: jsonData)
                guard let jsonarray = json.array else {return}
                self.newsData = jsonarray.map{ json -> News in
                    return News(
                        title: json["title"].stringValue,
                        back: json["back"].stringValue,
                        intro1: json["intro1"].stringValue,
                        intro2: json["intro2"].stringValue,
                        intro3: json["intro3"].stringValue
                    )
                }
                self.BackImage.image = UIImage(named: self.newsData[0].back)
                self.TitleLabel.text = self.newsData[cnt].title
                self.IntroLabel1.text = self.newsData[cnt].intro1
                self.IntroLabel2.text = self.newsData[cnt].intro2
                self.IntroLabel3.text = self.newsData[cnt].intro3
            }
            else {print("false")}
        }
        catch{
            print("false")
            
        }
    }
    
}
