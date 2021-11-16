//
//  CustomTabBar.swift
//  VK-Client
//
//  Created by Artem Firsov on 10/16/21.
//

import UIKit

final class CustomTabBar: UITabBar {
    
    private var width: CGFloat { self.bounds.width }
    private var height: CGFloat { self.bounds.height }
    private var centerWidth: CGFloat { self.bounds.width / 2 }
    private var radius: CGFloat = 27
    
    private func shapePath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.close()
        return path.cgPath
    }
    
    private func circlePath() -> CGPath {
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: centerWidth, y: 12), radius: radius, startAngle: .pi, endAngle: 0 * .pi, clockwise: true)
        return path.cgPath
    }

    private var shapeLayer: CALayer?
    private var circleLayer: CALayer?
    
    private func drawTabBar() {
        let shapeLayer = CAShapeLayer()
            shapeLayer.path = shapePath()
            shapeLayer.strokeColor = UIColor.lightGray.cgColor
            shapeLayer.fillColor = UIColor.white.cgColor
            shapeLayer.lineWidth = 1.0

            let circleLayer = CAShapeLayer()
            circleLayer.path = circlePath()
            circleLayer.strokeColor = UIColor.lightGray.cgColor
            circleLayer.fillColor = UIColor.white.cgColor
            circleLayer.lineWidth = 1.0

            if let oldShapeLayer = self.shapeLayer {
                self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
            } else {
                self.layer.insertSublayer(shapeLayer, at: 0)
            }

            if let oldCircleLayer = self.circleLayer {
                self.layer.replaceSublayer(oldCircleLayer, with: circleLayer)
            } else {
                self.layer.insertSublayer(circleLayer, at: 1)
            }

            self.shapeLayer = shapeLayer
            self.circleLayer = circleLayer
    }
    
    override func draw(_ rect: CGRect) {
        drawTabBar()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let pointIsInside = super.point(inside: point, with: event) 
        if pointIsInside == false {
            for subview in subviews {
                let pointInSubview = subview.convert(point, from: self)
                if subview.point(inside: pointInSubview, with: event) {
                    return true
                }
            }
        }
        return pointIsInside
    }
    
    
}
