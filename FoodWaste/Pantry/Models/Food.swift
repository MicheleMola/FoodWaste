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
  let _description: String

  init (name: String, quantity: String, expiration: String, image: String, _description: String) {
    self.name = name
    self.quantity = quantity
    self.expiration = expiration
    self.image = image
    self._description = _description
  }
  
  static func fetchItalianFood() -> [Food] {
    return [Food(name: "Uova", quantity: "3", expiration: "1 Giorno Rimanente", image: "eggs", _description: "Eggs"),
            Food(name: "Broccoli", quantity: "3", expiration: "2 Giorni Rimanenti", image: "broccoli", _description: "Broccoli"),
            Food(name: "Carote", quantity: "3", expiration: "3 Giorni Rimanenti", image: "carrot", _description: "Carrots"),
            Food(name: "Melenzane", quantity: "3", expiration: "5 Giorni Rimanenti", image: "eggplant", _description: "Eggplants"),
            Food(name: "Leerdammer", quantity: "3", expiration: "10 Giorni Rimanenti", image: "leerdammer", _description: "Leerdammer"),
            Food(name: "Parmigiano Reggiano", quantity: "3", expiration: "20 Giorni Rimanenti", image: "parmigiano", _description: "Parmesan Cheese"),
    ]
  }
  
  static func fetchEnglishFood() -> [Food] {
    return [Food(name: "Eggs", quantity: "3", expiration: "1 Day Left", image: "eggs", _description: "Eggs"),
            Food(name: "Broccoli", quantity: "3", expiration: "2 Days Left", image: "broccoli", _description: "Broccoli"),
            Food(name: "Carrots", quantity: "3", expiration: "3 Days Left", image: "carrot", _description: "Carrots"),
            Food(name: "Eggplants", quantity: "3", expiration: "5 Days Left", image: "eggplant", _description: "Eggplants"),
            Food(name: "Leerdammer", quantity: "3", expiration: "10 Days Left", image: "leerdammer", _description: "Leerdammer"),
            Food(name: "Parmesan Cheese", quantity: "3", expiration: "20 Days Left", image: "parmigiano", _description: "Parmesan Cheese"),
    ]
  }
  
}
