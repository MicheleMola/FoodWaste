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
  let id : String?

  init (name: String, quantity: String, expiration: String, image: String, id: String) {
    self.name = name
    self.quantity = quantity
    self.expiration = expiration
    self.image = image
    self.id = id
  }
  
  static func fetchItalianFood() -> [Food] {
    return [Food(name: "Uova", quantity: "3", expiration: "1 Giorno Rimanente", image: "eggs", id: ""),
            Food(name: "Broccoli", quantity: "3", expiration: "2 Giorni Rimanenti", image: "broccoli", id: ""),
            Food(name: "Carote", quantity: "3", expiration: "3 Giorni Rimanenti", image: "carrot", id: ""),
            Food(name: "Melenzane", quantity: "3", expiration: "5 Giorni Rimanenti", image: "eggplant", id: ""),
            Food(name: "Leerdammer", quantity: "3", expiration: "10 Giorni Rimanenti", image: "leerdammer", id: ""),
            Food(name: "Parmigiano Reggiano", quantity: "3", expiration: "20 Giorni Rimanenti", image: "parmigiano", id: ""),
    ]
  }
  
  static func fetchEnglishFood() -> [Food] {
    return [Food(name: "Eggs", quantity: "3", expiration: "1 Day Left", image: "eggs", id: ""),
            Food(name: "Broccoli", quantity: "3", expiration: "2 Days Left", image: "broccoli", id: ""),
            Food(name: "Carrots", quantity: "3", expiration: "3 Days Left", image: "carrot", id: ""),
            Food(name: "Eggplants", quantity: "3", expiration: "5 Days Left", image: "eggplant", id: ""),
            Food(name: "Leerdammer", quantity: "3", expiration: "10 Days Left", image: "leerdammer", id: ""),
            Food(name: "Parmesan Cheese", quantity: "3", expiration: "20 Days Left", image: "parmigiano", id: ""),
    ]
  }
  
}
