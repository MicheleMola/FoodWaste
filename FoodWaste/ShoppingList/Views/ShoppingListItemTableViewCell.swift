//
//  ShoppingListItemTableViewCell.swift
//  FoodWaste
//
//  Created by alfredo pinfildi on 03/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit

class ShoppingListItemTableViewCell: UITableViewCell {

  @IBOutlet weak var container: UIView!
  @IBOutlet weak var shadowLayer: UIView!
  @IBOutlet weak var itemName: UILabel!
  @IBOutlet weak var itemQuantity: UILabel!
  @IBOutlet weak var choosen: UIView!
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    
    self.selectionStyle = .none
    
    self.container.layer.masksToBounds = true
    self.container.layer.cornerRadius = 8
    
    self.shadowLayer.layer.cornerRadius = 8
    self.shadowLayer.layer.masksToBounds = false
    self.shadowLayer.layer.shadowOffset = CGSize(width: 0, height: 0)
    self.shadowLayer.layer.shadowColor = UIColor.black.cgColor
    self.shadowLayer.layer.shadowOpacity = 0.1
    self.shadowLayer.layer.shadowRadius = 4
    
    self.choosen.layer.cornerRadius = self.choosen.frame.width / 2
    self.choosen.backgroundColor = .clear
  
  }

  
  override func setSelected(_ selected: Bool, animated: Bool) {
    
    super.setSelected(selected, animated: animated)
    
  }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    for subview in self.subviews {
      
      for sub in subview.subviews {
        
        if String(describing: sub).range(of: "UITableViewCellActionButton") != nil {
          
          for view in sub.subviews {
            
            if String(describing: view).range(of: "UIButtonLabel") != nil {
              
              if let label = view as? UILabel {
                
                label.textColor = UIColor.black
                
              }
              
            }
            
          }
          
        }
        
      }
      
    }
    
  }
  
  
  func setUpCell (listItem: ShoppingListItem) {
    
    self.itemName.text = listItem.name
    self.itemQuantity.text = listItem.quantity
    
  }

}
