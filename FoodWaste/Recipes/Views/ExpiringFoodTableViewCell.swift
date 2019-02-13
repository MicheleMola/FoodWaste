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
  
    private let language = Locale.current.languageCode
    
    var foodExipiring: Food? {
        didSet {
            self.updateTableViewCell()
            self.changeColor()
        }
    }
    
    func changeColor (){
      if expirationDateCell != nil && expirationDateCell.text?.contains("1 day left") == true || expirationDateCell.text?.contains("2 days left") == true || expirationDateCell.text?.contains("3 days left") == true {
        expirationDateCell.textColor = UIColor.red
      }
      else if expirationDateCell != nil && expirationDateCell.text?.contains("1 giorno rimanente") == true || expirationDateCell.text?.contains("2 giorni rimanenti") == true || expirationDateCell.text?.contains("3 giorni rimanenti") == true {
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
            if let remainingDays = differenceFromCurrentDate(date: foods.expiration) {
              var infoRemainingDays = String()
              if language == "it" {
                infoRemainingDays = "\(remainingDays) giorni rimanenti"
              } else {
                infoRemainingDays = "\(remainingDays) days left"
              }
              expirationDateCell.text = infoRemainingDays
            }
          
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



