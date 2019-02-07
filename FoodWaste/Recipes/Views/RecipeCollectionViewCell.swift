//
//  RecipeCollectionViewCell.swift
//  FoodWaste
//
//  Created by Paolo Di Grazia on 03/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var suggestedRecipeImage: UIImageView!
    @IBOutlet weak var suggestedRecipeName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 12
        
    }
    
}






