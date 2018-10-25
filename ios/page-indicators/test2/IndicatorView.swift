//
//  indicator.swift
//  test2
//
//  Created by Joseph Bogale on 10/24/18.
//  Copyright © 2018 Joseph Bogale. All rights reserved.
//

import UIKit

class IndicatorView: UIView {
    let defaultColor = UIColor(red:0.51, green:0.58, blue:0.66, alpha:1.0)
    let selectedColor = UIColor.white
    var indicatorOn: Bool  = false {
        didSet{
            if indicatorOn == true {
                self.backgroundColor = selectedColor
            } else {
                self.backgroundColor = defaultColor
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = defaultColor
        self.translatesAutoresizingMaskIntoConstraints  = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
