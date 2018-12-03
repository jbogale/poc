//
//  AnimatedUIBUtton.swift
//  test2
//
//  Created by Joseph Bogale on 11/30/18.
//  Copyright © 2018 Joseph Bogale. All rights reserved.
//

import UIKit

class AnimatedUIBUtton: UIButton {
    var path: UIBezierPath!
    let dotColor =  UIColor.white.cgColor
    let numberOfLoadingDots = 3

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public func startProcessing(){
        self.setTitle("", for: .normal)
        self.isEnabled = false
        self.backgroundColor = UIColor(red:0.09, green:0.13, blue:0.30, alpha:1.0)

        //used https://stackoverflow.com/questions/42399720/fade-in-out-animation-for-a-series-of-dots as a reference
        let loaderIcons = createLoaderIcon()
        let replicationLayer = CAReplicatorLayer()
        
        replicationLayer.frame = CGRect(x: 35, y: 10
            , width: self.frame.width , height: self.frame.height)
        replicationLayer.addSublayer(loaderIcons)
        replicationLayer.instanceCount = numberOfLoadingDots
        replicationLayer.instanceTransform = CATransform3DMakeTranslation(20, 0, 0)
        
        let anim =  loaderIconAnimation()
        loaderIcons.add(anim, forKey: nil)
        replicationLayer.instanceDelay = anim.duration / Double(replicationLayer.instanceCount)
        layer.addSublayer(replicationLayer)
    }
    
    public func finishProcessing(){
        let checkMarkLayer = CAShapeLayer()
        backgroundColor = UIColor(red:0.03, green:0.31, blue:0.16, alpha:1.0)
        createCheckMarkPath()
 
        checkMarkLayer.path = self.path.cgPath
        checkMarkLayer.fillColor = backgroundColor?.cgColor
        checkMarkLayer.strokeColor = UIColor.white.cgColor
        checkMarkLayer.lineWidth = 6.0
        
        checkMarkLayer.add(checkMarkAnimation(), forKey: "drawLineAnimation")
        layer.addSublayer(checkMarkLayer)
    }

    public func resetButton(){
        _ = layer.sublayers?.popLast()
        isEnabled = true
        backgroundColor  = UIColor.blue
        setTitle("Claim Offer", for: .normal)
        
    }

    private  func createCheckMarkPath(){
        let centerX = self.frame.width / 2
        let centerY = (self.frame.height / 2)
        
        _ = self.layer.sublayers?.popLast()

        path = UIBezierPath()
        path.move(to: CGPoint(x: centerX - 11, y: centerY - 10))
        path.addLine(to: CGPoint(x: centerX, y: centerY + 10))
        path.addLine(to: CGPoint(x: centerX + 40, y: centerY - 15))
    }

    private func createLoaderIcon() -> CAShapeLayer {
        path = UIBezierPath(ovalIn:  CGRect(x: 35, y: 8, width: 12, height: 12))
        let loaderIcon = CAShapeLayer()
        loaderIcon.path = path.cgPath
        loaderIcon.fillColor  = dotColor
        loaderIcon.lineWidth = 4
        return loaderIcon
    }
    
    private func    loaderIconAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = 1.0
        animation.toValue = 0.1
        animation.duration = 1
        animation.repeatCount = .infinity
        return animation
    }

    private func checkMarkAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        /* set up animation */
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 0.5
        return animation
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
