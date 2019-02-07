//
//  RecipeDetailViewController.swift
//  FoodWaste
//
//  Created by Paolo Di Grazia on 03/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import Foundation
import UIKit


class RecipeDetailViewController: UITableViewController {
    
    @IBOutlet weak var detailRecipeImage: UIImageView!
    @IBOutlet weak var detailRecipeName: UILabel!
    @IBOutlet weak var detailRecipeDescription: UILabel!

    var roundButton: UIButton!
    var recipe: Recipe?

    
        override func viewDidLoad() {
            super.viewDidLoad()
            setupDetailView()
        }
    
        override func viewWillAppear(_ animated: Bool) {
            tableView.rowHeight = UITableView.automaticDimension
            //tableView.estimatedRowHeight = 900
            createFloatingButton()
        }
    
        override func viewDidLayoutSubviews() {
//            tableView.contentInset = UIEdgeInsets.zero
        }
    
        override var prefersStatusBarHidden: Bool {
            return true
        }
    
    //it gives you the ability to set the height of a certain cell and to use automatic height for the others
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 400
        case 1:
            return 55
        case 2:
            return 130
        case 3:
            return 44
        default:
            return UITableView.automaticDimension
        }
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    
    // facciamo il setup della detail view 
    func setupDetailView() {
        
        if let recipe = recipe {
        detailRecipeName.text = recipe.recipeName
        detailRecipeImage.image = UIImage(named: recipe.recipeImage)
        detailRecipeDescription.text = recipe.recipeDescription
        
        }
    }
    
    
    // function that creates a floating button
    func createFloatingButton() {
        roundButton = UIButton(type: .custom)
        roundButton.backgroundColor = .white
        roundButton.setImage(UIImage(named: "Cancel"), for: .normal)
        roundButton.layer.cornerRadius = 24
        roundButton.layer.borderWidth = 0.8
        roundButton.layer.borderColor = UIColor.black.cgColor
        
        roundButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        tableView.addSubview(roundButton)
        
        // Set position
        roundButton.translatesAutoresizingMaskIntoConstraints = false
        roundButton.rightAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.rightAnchor, constant: -24).isActive = true
        roundButton.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        roundButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        roundButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    // it gives the ability to the button to dismiss the detail view
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}




    






