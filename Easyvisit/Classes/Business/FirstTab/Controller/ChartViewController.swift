//
//  ChartViewController.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/24.
//

import UIKit
import ScrollableGraphView
import SnapKit
import SwiftyJSON

class ChartViewController: UIViewController {
    
    let date = Date()
    var indexData = [Index]()
    var cnt: Int = 0
    let historyTopCellID = "historyTopCellID"
    let historyCellID = "historyCellID"
    lazy var highdata: [Double] = []
    lazy var downdate: [Double] = [62, 68, 70, 71, 69, 78, 68, 68, 77, 63]
    let mo = [0,31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    lazy var graphView: ScrollableGraphView = {
        let gv = ScrollableGraphView(frame: .zero, dataSource: self)

        let firstLinePlot = LinePlot(identifier: "firstLinePlot")
        firstLinePlot.lineColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        firstLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        let firstDotPlot = DotPlot(identifier: "firstDotPlot")
        firstDotPlot.dataPointType = ScrollableGraphViewDataPointType.circle
        firstDotPlot.dataPointSize = 5
        firstDotPlot.dataPointFillColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        firstDotPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
       
        let secondLinePlot = LinePlot(identifier: "secondLinePlot")
        secondLinePlot.lineColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        secondLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        let secondDotPlot = DotPlot(identifier: "secondDotPlot")
        secondDotPlot.dataPointType = ScrollableGraphViewDataPointType.circle
        secondDotPlot.dataPointSize = 5
        secondDotPlot.dataPointFillColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        secondDotPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        let referenceLines = ReferenceLines()

        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = .black
        referenceLines.referenceLineLabelColor = UIColor.black
        referenceLines.relativePositions = [0, 0.2, 0.4, 0.6, 0.8, 1]
        referenceLines.dataPointLabelColor = .black

        gv.backgroundFillColor = .white
        gv.dataPointSpacing = 60

        gv.shouldAnimateOnStartup = true
        gv.shouldAdaptRange = true
        gv.shouldRangeAlwaysStartAtZero = true

        gv.addReferenceLines(referenceLines: referenceLines)
        gv.addPlot(plot: firstLinePlot)
        gv.addPlot(plot: firstDotPlot)
        gv.addPlot(plot: secondLinePlot)
        gv.addPlot(plot: secondDotPlot)
        
        return gv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        handyJSON()
        navigationController?.navigationBar.isHidden = true
        setUI()
    }
    
    lazy var WhiteImageView1: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 14
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var WhiteImageView2: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        layerView.layer.shadowOpacity = 1
        layerView.backgroundColor = .white
        layerView.layer.cornerRadius = 14
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var NavLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.frame = CGRect(x: 190.fw, y: 50.fh, width: 200.fw, height: 30.fh)
        label.textAlignment = .left
        label.text = indexData[self.cnt].name
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var TenLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.textAlignment = .left
        label.text = "近十天数据"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var whiteView: WhiteView = {
        let wv = WhiteView()
        wv.DateLabel.text = "\(month())月 \(day()) 日"
        wv.RoundLabel1.text = indexData[self.cnt].standardhigh
        wv.RoundLabel2.text = indexData[self.cnt].standardlow
        return wv
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
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceVertical = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(HistoryTopCollectionViewCell.self, forCellWithReuseIdentifier: historyTopCellID)
        collectionView.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: historyCellID)
        return collectionView
    }()
    
    func handyJSON(){
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "index", ofType: "json")!))
            if let jsonData = String(data: data,encoding: .utf8){
                let json = JSON(parseJSON: jsonData)
                guard let jsonarray = json.array else{return}
                self.indexData = jsonarray.map{ json -> Index in
                    return Index(
                        name: json["name"].stringValue,
                        standardhigh: json["standardhigh"].stringValue,
                        standardlow: json["standardlow"].stringValue,
                        highdata1: json["highdata1"].doubleValue,
                        highdata2: json["highdata2"].doubleValue,
                        highdata3: json["highdata3"].doubleValue,
                        highdata4: json["highdata4"].doubleValue,
                        highdata5: json["highdata5"].doubleValue,
                        highdata6: json["highdata6"].doubleValue,
                        highdata7: json["highdata7"].doubleValue,
                        highdata8: json["highdata8"].doubleValue,
                        highdata9: json["highdata9"].doubleValue,
                        highdata10: json["highdata10"].doubleValue,
                        
                        lowdata1: json["lowdata1"].doubleValue,
                        lowdata2: json["lowdata2"].doubleValue,
                        lowdata3: json["lowdata3"].doubleValue,
                        lowdata4: json["lowdata4"].doubleValue,
                        lowdata5: json["lowdata5"].doubleValue,
                        lowdata6: json["lowdata6"].doubleValue,
                        lowdata7: json["lowdata7"].doubleValue,
                        lowdata8: json["lowdata8"].doubleValue,
                        lowdata9: json["lowdata9"].doubleValue,
                        lowdata10: json["lowdata10"].doubleValue
                        
                    )
                }
                highdata = [self.indexData[self.cnt].highdata1, self.indexData[self.cnt].highdata2, self.indexData[self.cnt].highdata3,self.indexData[self.cnt].highdata4, self.indexData[self.cnt].highdata5, self.indexData[self.cnt].highdata6, self.indexData[self.cnt].highdata7, self.indexData[self.cnt].highdata8, self.indexData[self.cnt].highdata9, self.indexData[self.cnt].highdata10]
                downdate = [self.indexData[self.cnt].lowdata1, self.indexData[self.cnt].lowdata2, self.indexData[self.cnt].lowdata3, self.indexData[self.cnt].lowdata4, self.indexData[self.cnt].lowdata5, self.indexData[self.cnt].lowdata6, self.indexData[self.cnt].lowdata7, self.indexData[self.cnt].lowdata8, self.indexData[self.cnt].lowdata9, self.indexData[self.cnt].lowdata10]
            }
            else {print("false")}
        }
        catch{
            print("false")
        }
    }
    
    func setUI() {
        view.backgroundColor = .white
        view.addSubview(WhiteImageView1)
        view.addSubview(leftButton)
        view.addSubview(NavLabel)
        view.addSubview(WhiteImageView2)
        WhiteImageView1.addSubview(graphView)
        WhiteImageView1.addSubview(whiteView)
        WhiteImageView1.addSubview(TenLabel)
        WhiteImageView2.addSubview(collectionView)
        
        whiteView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().offset(0)
            make.height.equalTo(180)
        }
        
        TenLabel.snp.makeConstraints { make in
            make.top.equalTo(whiteView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(145)
            make.width.equalTo(150)
            make.height.equalTo(18)
        }
        
        WhiteImageView1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(450)
        }
        
        graphView.snp.makeConstraints { maker in
            maker.top.equalTo(TenLabel.snp.bottom).offset(10)
            maker.left.equalToSuperview().offset(40)
            maker.right.equalToSuperview().offset(-45)
            maker.height.equalTo(150)
        }
        
        WhiteImageView2.snp.makeConstraints { make in
            make.top.equalTo(WhiteImageView1.snp.bottom).offset(50)
            make.height.equalTo(250)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    

    

}

extension ChartViewController: ScrollableGraphViewDataSource {
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        switch(plot.identifier) {
            case "firstLinePlot":
            return Double(highdata[pointIndex])
            case "firstDotPlot":
            return Double(highdata[pointIndex])
            case "secondLinePlot":
                return downdate[pointIndex]
            case "secondDotPlot":
                return downdate[pointIndex]
            default:
                return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        
        if(day() - pointIndex > 0)
        {
            let mon = month()
            let da = day() - pointIndex
            return "\(mon)月 \(da) 日"
        }
        else
        {
            let mon = month() - 1
            let da = mo[mon] - pointIndex + day()
            return "\(mon)月 \(da) 日"
        }
        
    }
    
    func numberOfPoints() -> Int {
        return highdata.count
    }
    
    
    func year() -> Int {
            let calendar = NSCalendar.current
            let com = calendar.dateComponents([.year, .month, .day], from: date)
            return com.year!
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

extension  ChartViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: historyTopCellID, for: indexPath) as! HistoryTopCollectionViewCell
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: historyCellID, for: indexPath) as! HistoryCollectionViewCell
            let mon = month()
            let day = day()
            let da = ["\(mon)月 \(day)日", "\(mon)月 \(day-1)日", "\(mon)月 \(day-2)日", "\(mon)月 \(day-3)日"]
            let daa = ["\(indexData[self.cnt].highdata1) ~ \(indexData[self.cnt].highdata1)", "\(indexData[self.cnt].highdata2) ~ \(indexData[self.cnt].highdata2)", "\(indexData[self.cnt].highdata3) ~ \(indexData[self.cnt].highdata3)", "\(indexData[self.cnt].highdata4) ~ \(indexData[self.cnt].highdata4)" ]
            cell.DateLabel.text = da[indexPath.section - 1]
            cell.indexLabel.text = daa[indexPath.section - 1]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

}
    


extension ChartViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section{
        case 0:
            return CGSize(width: Int(screenWidth) - 40, height: 90.fh)
        default:
            return CGSize(width: Int(screenWidth) - 40, height: 40.fh)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(10.fh), right: CGFloat(0.fw))
    }
}
