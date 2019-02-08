//
//  MyCollectionViewCell.swift
//  FoodWaste
//
//  Created by Antonio Biondi on 02/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var cellImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var expirationLabel: UILabel!
  @IBOutlet weak var quantityLabel: UILabel!
  @IBOutlet weak var gradientCellView: UIView!
  
  func setLayoutCell(cell: UICollectionViewCell) {
    cell.layer.cornerRadius = 20.0
    cell.layer.borderWidth = 1.0
    cell.layer.borderColor = UIColor.clear.cgColor
    cell.layer.masksToBounds = false
    
    cell.layer.shadowColor = UIColor.black.cgColor
    cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
    cell.layer.shadowRadius = 15.0
    cell.layer.shadowOpacity = 0.5
    cell.layer.masksToBounds = false
    cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    
    gradientCellView.layer.cornerRadius = 20
    gradientCellView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    gradientCellView.layer.backgroundColor = UIColor.black.cgColor
    gradientCellView.layer.opacity = 0.5
  }
  
}
