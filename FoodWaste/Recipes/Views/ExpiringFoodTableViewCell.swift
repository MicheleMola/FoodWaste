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
        if expirationDateCell != nil && expirationDateCell.text?.contains("1 Day Left") == true || expirationDateCell.text?.contains("2 Days Left") == true || expirationDateCell.text?.contains("3 Days Left") == true {
            expirationDateCell.textColor = UIColor.red
        } else {
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
        
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }
    
    
    

    override func layoutSubviews() {
        super.layoutSubviews()
        

    }

}



