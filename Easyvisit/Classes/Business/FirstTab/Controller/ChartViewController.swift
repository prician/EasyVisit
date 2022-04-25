//
//  ChartViewController.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/24.
//

import UIKit
import ScrollableGraphView
import SnapKit

class ChartViewController: UIViewController {
    
    lazy var graphView: ScrollableGraphView = {
        let gv = ScrollableGraphView(frame: .zero, dataSource: self)
        let linePlot = LinePlot(identifier: "line")
        linePlot.fillColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        linePlot.lineColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        let rfLines = ReferenceLines()
        gv.shouldAdaptRange = true
        gv.shouldAnimateOnAdapt = true
        gv.shouldAnimateOnStartup = true
        gv.addPlot(plot: linePlot)
        gv.addReferenceLines(referenceLines: rfLines)
        let dotPlot = DotPlot(identifier: "dot")
        dotPlot.dataPointFillColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
        gv.addPlot(plot: dotPlot)
        return gv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        setUI()
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
        }
    
    func setUI() {
        view.backgroundColor = .white
        view.addSubview(graphView)
        view.addSubview(leftButton)
        graphView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(100)
            maker.width.equalTo(300)
            maker.height.equalTo(150)
            maker.centerX.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    var data: [Double] = [10,30,50,20,80,10,30,50,20,80,10,30,50,20,80,10,30,50,20,80]

}

extension ChartViewController: ScrollableGraphViewDataSource {
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        switch(plot.identifier) {
            case "line":
                return data[pointIndex]
        case "dot":
            return data[pointIndex]
            default:
                return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return "第\(pointIndex+1)天"
    }
    
    func numberOfPoints() -> Int {
        return data.count
    }
    
    
}
