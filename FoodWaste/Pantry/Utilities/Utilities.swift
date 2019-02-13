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

func differenceFromCurrentDate(date: String) -> String? {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "MM/dd/YYYY"
  dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
  
  let currentDate = NSDate()

  if let date = dateFormatter.date(from: date) {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
    let finalDate = calendar.date(from:components)
    
    if let diff = finalDate?.interval(ofComponent: .day, fromDate: currentDate as Date) {
      let diffAbs = abs(diff)
      
      return "\(diffAbs)"
    }
  }
  return nil
}

