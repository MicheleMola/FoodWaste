//
//  UIView+Circle.swift
//  FoodWaste
//
//  Created by Antonio Biondi on 06/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit

extension UIView {
  
  func createCircle() {
    let waveLayer = CAShapeLayer()

    let circlePath = UIBezierPath(arcCenter: self.center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi, clockwise: true)
    waveLayer.path = circlePath.cgPath
    waveLayer.strokeColor = UIColor.lightGray.cgColor
    waveLayer.lineWidth = 4
    waveLayer.fillColor = UIColor.clear.cgColor
    waveLayer.lineCap = CAShapeLayerLineCap.round
    self.layer.addSublayer(waveLayer)
  }

  @objc func addAnimatedWave() {
    let waveLayer = self.buildCircle(strokeColor: .black, fillColor: .clear, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi)
    self.layer.addSublayer(waveLayer)
    self.animateWave(waveLayer: waveLayer)
  }

  private func buildCircle(strokeColor: UIColor, fillColor: UIColor, startAngle: CGFloat, endAngle: CGFloat) -> CAShapeLayer {
    let waveLayer = CAShapeLayer()

    let circularPath = UIBezierPath(arcCenter: self.center, radius: 100, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    waveLayer.path = circularPath.cgPath

    waveLayer.strokeColor = strokeColor.cgColor
    waveLayer.lineWidth = 4
    waveLayer.fillColor = fillColor.cgColor
    waveLayer.lineCap = CAShapeLayerLineCap.round

    waveLayer.strokeEnd = 0
    return waveLayer
  }

  private func animateWave(waveLayer: CAShapeLayer) {

    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")

    basicAnimation.toValue = 1
    basicAnimation.duration = 2

    basicAnimation.fillMode = CAMediaTimingFillMode.forwards
    basicAnimation.isRemovedOnCompletion = false

    waveLayer.add(basicAnimation, forKey: "urSoBasic")
  }
  
}
