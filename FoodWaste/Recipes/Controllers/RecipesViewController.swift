//
//  RecipesViewController.swift
//  FoodWaste
//
//  Created by Paolo Di Grazia on 03/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import Foundation
import UIKit

class RecipesViewController: UIViewController {
  
    let language = Locale.current.languageCode
  
    // Created two IBOutlets to control the UICollectionView and UITableView
    @IBOutlet weak var recipesCollectionView: UICollectionView!
    @IBOutlet weak var expirationDatesTableView: UITableView!
    @IBOutlet weak var suggestedRecipesLabel: UILabel!
    @IBOutlet weak var expiringFoodLabel: UILabel!

    
    //initializing two variables. The first one is recipes, of type RECIPE, initialized as an empty Array and the second one is expiringFood where we access the method fetchFood() that will return an array of food.
    var recipes: [Recipe] = []
    var expiringEnglishFood = Food.fetchEnglishFood()
    var expiringItalianFood = Food.fetchItalianFood()
    
    func getRecipes() {
      var filename = "recipes"
      
      switch language {
      case "it": filename = "ricette"
      default: break
      }
      
      if let recipes: [Recipe] = loadJson(filename: filename) {
        self.recipes = recipes
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesCollectionView?.dataSource = self
        recipesCollectionView?.delegate = self
        expirationDatesTableView?.dataSource = self
        expirationDatesTableView.separatorStyle = .none
      
        if language == "it" {
          expiringFoodLabel.accessibilityLabel = "Lista del cibo in scadenza. Troverai i dieci cibi che sono più vicini alla scadenza."
          suggestedRecipesLabel.accessibilityLabel = "Ricette suggerite del giorno. Swipe verso sinistra per trovare tutte le ricette."
        }
        else {
          expiringFoodLabel.accessibilityLabel = "Expiring food list. You will find the ten foods that are approaching the expiration date."
          suggestedRecipesLabel.accessibilityLabel = "Today suggested recipes. Swipe to the right to find all the recipes."
        }
        
        
        self.getRecipes()
        
    }
  
}

// takes care of the collection view
extension RecipesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCollectionViewCell
        cell.suggestedRecipeName.text = recipes[indexPath.row].recipeName
        cell.suggestedRecipeImage.image = UIImage(named: recipes[indexPath.row].recipeImage)
        cell.isAccessibilityElement = true
        cell.accessibilityLabel = recipes[indexPath.row].recipeName
        return  cell
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "detailRecipeViewController") as! RecipeDetailViewController
        detailViewController.recipe = recipes[indexPath.row]
        DispatchQueue.main.async {
            self.present(detailViewController,animated: true,completion: nil)
        }
    }
}


extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}



// takes care of tableview
extension RecipesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if language == "it" {
        return expiringEnglishFood.count
      } else {
        return expiringEnglishFood.count
      }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = expirationDatesTableView.dequeueReusableCell(withIdentifier: "ExpiringFoodCell") as! ExpiringFoodTableViewCell
      if language == "it" {
        cell.foodExipiring = expiringItalianFood[indexPath.row]
      } else {
        cell.foodExipiring = expiringEnglishFood[indexPath.row]
      }
      return cell
    }
    
}




