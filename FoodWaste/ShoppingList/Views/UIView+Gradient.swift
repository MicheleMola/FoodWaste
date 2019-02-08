//
//  UIView+Gradient.swift
//  FoodWaste
//
//  Created by alfredo pinfildi on 02/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit

extension UIView {
  
  func addGradient (colors: [CGColor], locations: [NSNumber]) {
    
    //gradient layer
    let gradientLayer = CAGradientLayer()
    
    //define colors
    gradientLayer.colors = colors
    
    //define locations of colors as NSNumbers in range from 0.0 to 1.0
    //if locations not provided the colors will spread evenly
    gradientLayer.locations = locations
    
    //define frame
    gradientLayer.frame = self.bounds
    
    //insert the gradient layer to the view layer
    self.layer.insertSublayer(gradientLayer, at: 0)
    
  }
  
}
