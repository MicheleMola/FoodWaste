//
//  Recipe.swift
//  FoodWaste
//
//  Created by Paolo Di Grazia on 08/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import Foundation
import UIKit

class Recipe: Codable {
    
    var recipeName: String
    var recipeImage: String
    var recipeDescription: String
    
    
    init (recipeName: String, recipeImage: String, recipeDescription: String) {
        self.recipeName = recipeName
        self.recipeImage = recipeImage
        self.recipeDescription = recipeDescription
    }
}
