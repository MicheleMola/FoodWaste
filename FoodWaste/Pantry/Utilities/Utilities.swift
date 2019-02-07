//
//  Utilities.swift
//  FoodWaste
//
//  Created by Antonio Biondi on 03/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit

func loadJson<T: Codable>(filename fileName: String) -> T? {
  if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      let jsonData = try decoder.decode(T.self, from: data)
      return jsonData
    } catch {
      print("error:\(error)")
    }
  }
  return nil
}
