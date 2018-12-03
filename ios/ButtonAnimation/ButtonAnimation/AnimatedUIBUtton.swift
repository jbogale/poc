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
    let checkMarkImageView  = UIImageView(image: UIImage(named: "Check"))
    var closure:() -> Void = { }
    var buttonDimension: CGFloat {
        return self.bounds.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func setUp(closure: @escaping ()-> Void){
        self.closure = closure
        checkMarkImageView.contentMode = .scaleAspectFit
        checkMarkImageView.frame = CGRect(x: bounds.midX - (buttonDimension / 2), y: bounds.midY - (buttonDimension / 2), width: buttonDimension, height: buttonDimension)
        self.addSubview(checkMarkImageView)
        checkMarkImageView.alpha = 0
    }

    public func startProcessing(){
        self.isEnabled = false
        setTitle("", for: .normal)
        self.backgroundColor = UIColor(red:0.18, green:0.57, blue:0.93, alpha:1.0)

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
        _ = layer.sublayers?.popLast()
        setSuccessBackground()
    }

    public func resetButton(){
        isEnabled = true
        backgroundColor  = UIColor(red:0.18, green:0.57, blue:0.93, alpha:1.0)
        setTitle("Claim Offer", for: .normal)
        checkMarkImageView.alpha = 0
    }
    
    private func setSuccessBackground() {
        UIView.animate(withDuration: 1.5, animations: {
            self.backgroundColor = UIColor(red:0.24, green:0.53, blue:0.24, alpha:1.0)
            self.checkMarkImageView.alpha = 1
        }, completion: { (_) in
            self.checkMarkImageView.alpha = 0
            self.setTitle("Bet Now", for: .normal)
            self.closure()
        })
    }
 
    private func createLoaderIcon() -> CAShapeLayer {
        path = UIBezierPath(ovalIn:  CGRect(x: 35, y: 8, width: 12, height: 12))
        let loaderIcon = CAShapeLayer()
        loaderIcon.path = path.cgPath
        loaderIcon.fillColor  = dotColor
        loaderIcon.lineWidth = 5
        return loaderIcon
    }
    
    private func loaderIconAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = 1.0
        animation.toValue = 0.1
        animation.duration = 1
        animation.repeatCount = .infinity
        return animation
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
