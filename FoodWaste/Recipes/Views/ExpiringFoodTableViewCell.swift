//
//  ExpiringFoodTableViewCell.swift
//  FoodWaste
//
//  Created by Paolo Di Grazia on 03/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit

class ExpiringFoodTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImageCell: UIImageView!
    @IBOutlet weak var foodNameCell: UILabel!
    @IBOutlet weak var expirationDateCell: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    var foodExipiring: Food? {
        didSet {
            self.updateTableViewCell()
            self.changeColor()
        }
    }
    
    func changeColor (){
      if expirationDateCell != nil && expirationDateCell.text?.contains("1 Day left") == true || expirationDateCell.text?.contains("2 Days left") == true || expirationDateCell.text?.contains("3 Days left") == true {
        expirationDateCell.textColor = UIColor.red
      }
      else if expirationDateCell != nil && expirationDateCell.text?.contains("1 Giorno Rimanente") == true || expirationDateCell.text?.contains("2 Giorni Rimanenti") == true || expirationDateCell.text?.contains("3 Giorni Rimanenti") == true {
        expirationDateCell.textColor = UIColor.red
      }
      else {
        expirationDateCell.textColor = UIColor.black
      }
    }
    

    private func updateTableViewCell() {
        if let foods = foodExipiring {
          foodImageCell.image = UIImage(named: foods.image)
            foodNameCell.text = foods.name
            expirationDateCell.text = foods.expiration
        } else {
            foodImageCell.image = nil
            foodNameCell.text = nil
            expirationDateCell.text = nil
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.shadowView.layer.cornerRadius = 8
        self.shadowView.layer.masksToBounds = false
        self.shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowOpacity = 0.1
        self.shadowView.layer.shadowRadius = 4
    }

}



