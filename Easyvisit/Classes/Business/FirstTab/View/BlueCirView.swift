//
//  BlueCirView.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/28.
//

import UIKit
import ScrollableGraphView

class BlueCirView: UIView {
    
    let num: [Double] = [22, 25, 34, 28, 49, 30, 21, 40, 44,30]
    let date = Date()
    let mo = [0,31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configUI()
    }
   
    lazy var NameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 18)
        label.frame = CGRect(x: 150.fw, y: 20.fh, width: 200.fw, height: 30.fh)
        label.textAlignment = .left
        label.text = "问卷曲线"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var explainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "TimesNewRomanPS-ItalicMT", size: 10)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "20 十分正常\n20～40 正常良好\n40～60 轻度焦虑\n60～80 中度焦虑\n80～100 重度焦虑"
        label.numberOfLines = 0
        return label
    }()
    
    
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
    
    func configUI(){
        self.addSubview(graphView)
        self.addSubview(explainLabel)
        self.addSubview(NameLabel)
        
        graphView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(NameLabel.snp.bottom).offset(20)
            make.height.equalTo(160)
        }
        
        explainLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(270)
            make.width.equalToSuperview()
            make.top.equalTo(graphView.snp.bottom)
            make.height.equalTo(100)
        }
        

        
    }
   
}

extension BlueCirView: ScrollableGraphViewDataSource {
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        
        switch(plot.identifier) {
            case "LinePlot":
            return num[pointIndex]
            case "DotPlot":
            return num[pointIndex]

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
        return num.count
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
