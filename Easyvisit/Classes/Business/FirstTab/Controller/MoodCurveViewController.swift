//
//  MoodCurveViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/28.
//

import UIKit
import CoreML
import SwiftyJSON
import ScrollableGraphView

class MoodCurveViewController: UIViewController {
    
    var diaryData = [MoodCurve]()
    var mood = [Double]()
    let model = posNegClassify_1()
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        getData()
        configUI()
        // Do any additional setup after loading the view.
    }
    
    func getData(){
        handyJSON()
        for indexPath in 0...diaryData.count - 1  {
            let input = posNegClassify_1Input(text: diaryData[indexPath].content)
            guard let outdata = try? model.prediction(input: input) else{
                return
            }
            if(outdata.label == "neg"){
                diaryData[indexPath].index = diaryData[indexPath].index - 50
                print(diaryData[indexPath].index)
            }
            
            mood.append(diaryData[indexPath].index)
        }
        
    }
    
    
    lazy var graphView: ScrollableGraphView = {
        let gv = ScrollableGraphView(frame: .zero, dataSource: self)

        let LinePlot = LinePlot(identifier: "LinePlot")
        LinePlot.lineColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        LinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        let DotPlot = DotPlot(identifier: "DotPlot")
        DotPlot.dataPointType = ScrollableGraphViewDataPointType.circle
        DotPlot.dataPointSize = 5
        DotPlot.dataPointFillColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        DotPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
    
        
        let referenceLines = ReferenceLines()

        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = .black
        referenceLines.referenceLineLabelColor = UIColor.black
        referenceLines.relativePositions = [0, 0.2, 0.4, 0.6, 0.8, 1]
        referenceLines.dataPointLabelColor = .black

        gv.backgroundFillColor = UIColor.white
        gv.dataPointSpacing = 60

        gv.shouldAnimateOnStartup = true
        gv.shouldAdaptRange = true
        gv.shouldRangeAlwaysStartAtZero = true

        gv.addReferenceLines(referenceLines: referenceLines)
        gv.addPlot(plot: LinePlot)
        gv.addPlot(plot: DotPlot)
        gv.showsHorizontalScrollIndicator = false
        
        return gv
    }()

    lazy var WhiteView1: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 14
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var WhiteView2: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 14
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var blueView: BlueCirView = {
        let bV = BlueCirView()
        bV.layer.cornerRadius = 100
        return bV
    }()
    
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
    
    lazy var IntroLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 20)
        label.textAlignment = .left
        label.text = "当你在追光，你与光同航 ❤️"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var DateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 32)
        label.textAlignment = .left
        label.text = "\(month()) 月 \(day()) 日"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var NavLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.frame = CGRect(x: 170.fw, y: 50.fh, width: 200.fw, height: 30.fh)
        label.textAlignment = .left
        label.text = "心情曲线"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var nearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.frame = CGRect(x: 170.fw, y: 50.fh, width: 200.fw, height: 30.fh)
        label.textAlignment = .left
        label.text = "心情曲线"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    func configUI(){
        view.addSubview(WhiteView1)
        view.addSubview(WhiteView2)
        WhiteView2.addSubview(graphView)
        WhiteView1.addSubview(blueView)
        WhiteView2.addSubview(nearLabel)
        view.addSubview(leftButton)
        WhiteView1.addSubview(DateLabel)
        WhiteView1.addSubview(IntroLabel)
        view.addSubview(NavLabel)
        
        WhiteView1.snp.makeConstraints { make in
            make.top.equalTo(leftButton.snp.bottom).offset(20)
            make.height.equalTo(400)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        WhiteView2.snp.makeConstraints { make in
            make.top.equalTo(WhiteView1.snp.bottom).offset(45)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(270)
        }
        
        blueView.snp.makeConstraints { make in
            make.top.equalTo(DateLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(90)
            make.width.height.equalTo(200)
        }
        
        DateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(130)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        IntroLabel.snp.makeConstraints { make in
            make.top.equalTo(blueView.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(70)
            make.width.equalTo(250)
        }
        
        nearLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(160)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        graphView.snp.makeConstraints { make in
            make.top.equalTo(nearLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(160)
        }
        
    }
    
    func handyJSON(){
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "moodCurve", ofType: "json")!))
            if let jsonData = String(data: data,encoding: .utf8){
                let json = JSON(parseJSON: jsonData)
                guard let jsonarray = json.array else{return}
                self.diaryData = jsonarray.map{ json -> MoodCurve in
                    return MoodCurve(
                        
                        content: json["content"].stringValue,
                        index: json["index"].doubleValue
                        
                    )
                }
            }
            else {print("false")}
        }
        catch{
            print("false")
        }
    }
}


extension MoodCurveViewController: ScrollableGraphViewDataSource {
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        
        switch(plot.identifier) {
            case "LinePlot":
            return mood[pointIndex]
            case "DotPlot":
            return mood[pointIndex]

            default:
                return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return "\(month())月 \(day()-(pointIndex-1)) 日"
    }
    
    func numberOfPoints() -> Int {
        return mood.count
    }
    

    func month() -> Int {
            let calendar = NSCalendar.current
            let com = calendar.dateComponents([.year, .month, .day], from: date)
            return com.month!
    }

    func day() -> Int {
            let calendar = NSCalendar.current
            let com = calendar.dateComponents([.year, .month, .day], from: date)
            return com.day!
    }
    
    
    
}
