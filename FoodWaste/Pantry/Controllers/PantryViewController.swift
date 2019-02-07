//
//  PantryViewController.swift
//  FoodWaste
//
//  Created by Antonio Biondi on 01/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit

class PantryViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {

  @IBOutlet weak var foodCollectionView: UICollectionView!
  
  private let itemsPerRow: CGFloat = 2
  private let sectionInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
  var collectionTest: [Food] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.getFood()
    self.setCollectionViewLayout()
    self.hideKeyboardWhenTappedAround()
  }
  
  func getFood() {
    if let collectionTest: [Food] = loadJson(filename: "food") {
      self.collectionTest = collectionTest
    }
  }
  
  func setCollectionViewLayout() {
    let paddingSpace = sectionInsets.left * (itemsPerRow+1)
    let availableWidth = view.frame.width - paddingSpace
    let sizePerItem = availableWidth / itemsPerRow
    
    let layout = foodCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: sizePerItem, height: sizePerItem)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return collectionTest.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pantryCell", for: indexPath) as! MyCollectionViewCell
    
    cell.nameLabel.text = collectionTest[indexPath.item].name
    cell.quantityLabel.text = collectionTest[indexPath.item].quantity
    cell.expirationLabel.text = collectionTest[indexPath.item].expiration
    cell.cellImage.image = UIImage(named: collectionTest[indexPath.item].image)
    cell.cellImage.layer.shadowColor = UIColor.black.cgColor
    cell.cellImage.layer.shadowOpacity = 1
    
    cell.setLayoutCell(cell: cell)
    
    return cell
  }
  
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PantryViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
}
