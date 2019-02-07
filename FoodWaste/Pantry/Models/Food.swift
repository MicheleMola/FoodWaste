//
//  PantryItem.swift
//  FoodWaste
//
//  Created by Antonio Biondi on 02/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit

class Food: NSObject, Codable {
  
  let name : String
  let quantity : String
  let expiration : String
  let image : String

  init (name: String, quantity: String, expiration: String, image: String) {
    self.name = name
    self.quantity = quantity
    self.expiration = expiration
    self.image = image
  }
  
}
