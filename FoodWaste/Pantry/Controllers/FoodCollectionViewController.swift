//
//  FoodCollectionViewController.swift
//  FoodWaste
//
//  Created by Antonio Biondi on 08/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit

private let reuseIdentifier = "pantryCell"

class FoodCollectionViewController: UICollectionViewController {
  
  private let itemsPerRow: CGFloat = 2
  private let sectionInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
  var collectionTest: [Food] = []
  
  
  @IBOutlet var foodCollectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()

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

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
      
    cell.nameLabel.text = collectionTest[indexPath.item].name
    cell.quantityLabel.text = collectionTest[indexPath.item].quantity
    cell.expirationLabel.text = collectionTest[indexPath.item].expiration
    cell.cellImage.image = UIImage(named: collectionTest[indexPath.item].image)
    cell.cellImage.layer.shadowColor = UIColor.black.cgColor
    cell.cellImage.layer.shadowOpacity = 1
      
    cell.setLayoutCell(cell: cell)
      
    return cell
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
  
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FoodCollectionViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
