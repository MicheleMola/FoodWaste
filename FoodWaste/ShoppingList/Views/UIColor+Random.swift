//
//  UIColor+Random.swift
//  FoodWaste
//
//  Created by alfredo pinfildi on 02/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit

extension UIColor {
  
  static func random () -> UIColor {
    
    return UIColor (
      red: CGFloat.random(in: 0...1),
      green: CGFloat.random(in: 0...1),
      blue: CGFloat.random(in: 0...1),
      alpha: 1.0
    )
    
  }
}
