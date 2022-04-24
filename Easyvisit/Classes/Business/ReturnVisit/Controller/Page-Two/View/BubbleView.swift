//
//  BubbleView.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/23.
//

import UIKit

class BubbleView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(2)
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.beginPath()
        context?.move(to: .zero)
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: 20, y: 0), radius: 20, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: false)
        path.addArc(center: CGPoint(x: 20, y: -15), radius: 25, startAngle: CGFloat.pi, endAngle: CGFloat.pi / 2, clockwise: true)
        context?.addPath(path)
        context?.setFillColor(UIColor.white.cgColor)
        context?.fillPath()
        context?.strokePath()
    }

}
