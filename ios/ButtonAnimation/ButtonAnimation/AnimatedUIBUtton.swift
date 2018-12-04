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
    var closure:() -> Void = { }

    private var checkMarkImageView: UIImageView =  UIImageView(image: UIImage(named: "Check"))
    private var buttonTitle: String = ""

    
    private var loaderIconDiameter: CGFloat {
        return bounds.height / 4
    }
    
    private var buttonDimension: CGFloat {
        return bounds.height / 2
    }
    private var checkMarkFrame: CGRect {
        return CGRect(x: bounds.midX - (bounds.height / 2), y: bounds.midY - (buttonDimension / 2), width: buttonDimension, height: buttonDimension)
    }
    
    private var createLoaderIcon:  CAShapeLayer {
        //TODO: Calculate the oval diameter relative to the height of the button
        path = UIBezierPath(ovalIn:  CGRect(x: 35, y: 8, width: loaderIconDiameter, height: loaderIconDiameter))
        let loaderIcon = CAShapeLayer()
        loaderIcon.path = path.cgPath
        loaderIcon.fillColor  = UIColor.white.cgColor
        loaderIcon.lineWidth = 5
        return loaderIcon
    }

    private var loaderIconAnimation: CABasicAnimation {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = 1.0
        animation.toValue = 0.1
        animation.duration = 1
        animation.repeatCount = .infinity
        return animation
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        buttonTitle = title(for: .normal)!
        checkMarkImageView.contentMode = .scaleAspectFit
        checkMarkImageView.frame = checkMarkFrame
        self.addSubview(checkMarkImageView)
        checkMarkImageView.alpha = 0
    }

    public func startProcessing(closure: @escaping ()-> Void){
        self.closure = closure
        self.isEnabled = false
        setTitle("", for: .normal)
        backgroundColor = UIColor(red:0.18, green:0.57, blue:0.93, alpha:1.0)
    
        //used https://stackoverflow.com/questions/42399720/fade-in-out-animation-for-a-series-of-dots as a reference
        let loaderIcons = createLoaderIcon
        let replicationLayer = CAReplicatorLayer()
        
        replicationLayer.frame = CGRect(x: 35, y: 10
            , width: self.frame.width , height: self.frame.height)
        replicationLayer.addSublayer(loaderIcons)
        replicationLayer.instanceCount = 3
        replicationLayer.instanceTransform = CATransform3DMakeTranslation(20, 0, 0)
        
        let anim =  loaderIconAnimation
        loaderIcons.add(anim, forKey: nil)
        replicationLayer.instanceDelay = anim.duration / Double(replicationLayer.instanceCount)
        layer.addSublayer(replicationLayer)
    }

    public func finishProcessing(){
        _ = layer.sublayers?.popLast()
        UIView.animate(withDuration: 1.5, animations: {
            self.backgroundColor = UIColor(red:0.24, green:0.53, blue:0.24, alpha:1.0)
            self.checkMarkImageView.alpha = 1
        }, completion: { (_) in
            self.checkMarkImageView.alpha = 0
            //TODO: create a helper method to set this title from vc
            self.setTitle("Bet Now", for: .normal)
            self.closure()
        })
    }

    public func resetBackToInitialState(){
        isEnabled = true
        backgroundColor  = UIColor(red:0.18, green:0.57, blue:0.93, alpha:1.0)
        setTitle(buttonTitle, for: .normal)
        checkMarkImageView.alpha = 0
    }
}
