//
//  FoodCollectionViewController.swift
//  FoodWaste
//
//  Created by Antonio Biondi on 08/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit
import CloudKit

private let reuseIdentifier = "pantryCell"

class FoodCollectionViewController: UICollectionViewController {
  
  private let itemsPerRow: CGFloat = 2
  private let sectionInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
  var collectionTest: [Food] = []
  
  
  @IBOutlet var foodCollectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()

  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    self.getFood()
    self.setCollectionViewLayout()
    self.hideKeyboardWhenTappedAround()
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return collectionTest.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    let editPantryView: EditPantryViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditPantryViewController") as! EditPantryViewController
    editPantryView.food = collectionTest[indexPath.row]
    self.navigationController?.pushViewController(editPantryView, animated: true)
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
      
    cell.nameLabel.text = collectionTest[indexPath.item].name
    cell.quantityLabel.text = collectionTest[indexPath.item].quantity
    cell.expirationLabel.text = collectionTest[indexPath.item].expiration
    cell.cellImage.image = UIImage(named: collectionTest[indexPath.item].image)
    cell.cellImage.layer.shadowColor = UIColor.black.cgColor
    cell.cellImage.layer.shadowOpacity = 1
    
    cell.isAccessibilityElement = true
    cell.accessibilityLabel = "\(cell.nameLabel.text!), \(cell.quantityLabel.text!), \(cell.expirationLabel.text!)"
    
    cell.setLayoutCell(cell: cell)
      
    return cell
  }
  
  func getFood() {
    
      let privateDatabase = CKContainer.default().privateCloudDatabase
    
      let query = CKQuery(recordType: "Food", predicate: NSPredicate(value: true))
    
      query.sortDescriptors = [NSSortDescriptor(key: "Name", ascending: true)]
    
      privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
        
        DispatchQueue.main.sync {
          self.processResponseForQuery(records, error: error)
        }
      }
  }
  
  private func processResponseForQuery(_ records: [CKRecord]?, error: Error?) {
    var message = ""
    collectionTest = []

    if let error = error {
      print(error)
      message = "Error Fetching Items for List"

    } else if let records = records {
      for record in records {

        let food = Food(name: record["Name"]!, quantity: record["Quantity"]!, expiration: record["Expiration"]!, image: "eggs", id: record.recordID.recordName)

        collectionTest.append(food)

      }

      print(collectionTest.count)

      if collectionTest.count == 0 {
        message = "No Items Found"
      }

    } else {
      message = "No Items Found"
    }

    if message.isEmpty {
      foodCollectionView.reloadData()
    } else {
      print(message)
    }

  }
  
  func setCollectionViewLayout() {
    let paddingSpace = sectionInsets.left * (itemsPerRow+1)
    let availableWidth = view.frame.width - paddingSpace
    let sizePerItem = availableWidth / itemsPerRow
    
    let layout = foodCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: sizePerItem, height: sizePerItem)
  }
  
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FoodCollectionViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }


}
