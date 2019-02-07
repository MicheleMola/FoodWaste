//
//  Food.swift
//  FoodWaste
//
//  Created by Paolo Di Grazia on 03/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import Foundation
import UIKit

struct Food {
    
    var foodName: String
    var foodImage: UIImage?
    var foodDescription: String
    var foodExpirationDate: String
    
    init(foodName: String, foodImage: UIImage, foodDescription: String, foodExpirationDate: String) {
        self.foodName = foodName
        self.foodImage = foodImage
        self.foodDescription = foodDescription
        self.foodExpirationDate = foodExpirationDate
    }
    
    // A function that we use later to fetch the data to populate our expiratiobDatesTableView. It returns an array of type "Food".
    static func fetchFood() -> [Food] {
        return [Food(foodName: "Eggs", foodImage: UIImage(named: "eggs")!, foodDescription: "Eggs", foodExpirationDate: "1 Day Left"),
                Food(foodName: "Broccoli", foodImage: UIImage(named: "broccoli")!, foodDescription: "Broccoli", foodExpirationDate: "2 Days Left"),
                Food(foodName: "Carrots", foodImage: UIImage(named: "carrot")!, foodDescription: "Carrots", foodExpirationDate: "3 Days Left"),
                Food(foodName: "Eggplants", foodImage: UIImage(named: "eggplant")!, foodDescription: "Eggplants", foodExpirationDate: "5 Days Left"),
                Food(foodName: "Leerdammer", foodImage: UIImage(named: "leerdammer")!, foodDescription: "Leerdammer", foodExpirationDate: "10 Days Left"),
                Food(foodName: "Parmesan Cheese", foodImage: UIImage(named: "parmigiano")!, foodDescription: "Parmesan Cheese", foodExpirationDate: "20 Days Left"),
                ]
    }
}
