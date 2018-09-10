//
//  File.swift
//  MobiliteDynamique
//
//  Created by Pierre Bathellier on 30/11/2017.
//  Copyright © 2017 Pierre Bathellier. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class PushButton: UIButton{
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.green.setFill()
        path.fill()
    }
}
