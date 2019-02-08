//
//  IngredientListTableViewCell.swift
//  FoodWaste
//
//  Created by Paolo Di Grazia on 08/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit

class IngredientListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ingredient: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
