//
//  SoppingListViewController.swift
//  FoodWaste
//
//  Created by alfredo pinfildi on 02/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit
import MultipeerConnectivity


class ShoppingListViewController: UIViewController {
  
  var peers: [Peer] = []
  var shoppingListItems: [ShoppingListItem] = []
  var colors: [UIColor] = []
  let mcServiceController = MCService()
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    setupColors()
    setupPeers()
    setupShoppingListItems()
    mcServiceController.delegate = self
    mcServiceController.startAdvertiser (activate: true)
    mcServiceController.setupBrowser()
    
  }
  
  
  func setupColors () {
    
    colors.append(UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1))
    colors.append(UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1))
    colors.append(UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1))
    colors.append(UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1))
    colors.append(UIColor(red: 243/255, green: 156/255, blue: 18/255, alpha: 1))
    colors.append(UIColor(red: 25/255, green: 42/255, blue: 86/255, alpha: 1))
    
  }
  
  
  func setupPeers () {
    
    peers.append(Peer(name: "Alfredo", color: colors[0]))
    peers.append(Peer(name: "Luigi", color: colors[1]))
    peers.append(Peer(name: "Paolo", color: colors[2]))
    peers.append(Peer(name: "Michele", color: colors[4]))
    peers.append(Peer(name: "Renato", color: colors[5]))
    peers.append(Peer(name: "Gigi", color: colors[3]))
    
  }
  
  
  func setupShoppingListItems () {
    
    shoppingListItems.append(ShoppingListItem(name: "Fusilli", quantity: "1 kg"))
    shoppingListItems.append(ShoppingListItem(name: "Pomodoro datterino", quantity: "0,5 kg"))
    shoppingListItems.append(ShoppingListItem(name: "Cereali Nestlè", quantity: "2 confezioni"))
    shoppingListItems.append(ShoppingListItem(name: "Nutella", quantity: "0,8 kg"))
    
  }
  
}


extension ShoppingListViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return peers.count + 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peer", for: indexPath) as! PeerCollectionViewCell
    
    if indexPath.row == peers.count {
    
      cell.setUpButton()
      cell.delegate = self
    
    } else {
      cell.setUpCell (peer: peers[(indexPath.row)-1])
    }
        
    return cell
    
  }
  
  
}


extension ShoppingListViewController: UICollectionViewDelegate {
  
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let action = UIContextualAction(style: .normal, title: "      ", handler: {(action, view, completionHandler) in
      
      let cell = tableView.cellForRow(at: indexPath) as! ShoppingListItemTableViewCell
      cell.choosen.backgroundColor = self.colors[0]
      completionHandler (true)
      
    })
    
    action.image = UIImage(named: "ball")
    action.backgroundColor = .white
    UIImageView.appearance().tintColor = self.colors[0]
    
    
    let configuration = UISwipeActionsConfiguration (actions: [action])
    
    return configuration
    
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let action = UIContextualAction(style: .normal, title: "      ", handler: {
      (action, view, completionHandler) in
      
      self.shoppingListItems.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
      completionHandler (true)
    })
    
    action.image = UIImage(named: "check")
    action.backgroundColor = .white
    UIImageView.appearance().tintColor = .black
    

    let configuration = UISwipeActionsConfiguration (actions: [action])
    
    return configuration
    
  }
  
}


extension ShoppingListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return shoppingListItems.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "SLItem", for: indexPath) as! ShoppingListItemTableViewCell
    cell.setUpCell (listItem: shoppingListItems[indexPath.row])
    return cell
    
  }
  
}


extension ShoppingListViewController: UITableViewDelegate {}


extension ShoppingListViewController: ShoppingListDelegate {
  
  func showSimpleActionSheet () {
    
    self.mcServiceController.browserSwitcher (activate: true)
    self.mcServiceController.mcBrowser.delegate = self
    
    self.present (mcServiceController.mcBrowser, animated: true, completion: nil)
    
    /*let alert = UIAlertController(title: "Find Roommates", message: "Share the shopping list with your roommates", preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Approve", style: .default, handler: { (_) in
      print("User click Approve button")
    }))
    
    alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { (_) in
      print("User click Edit button")
    }))
    
    alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
      print("User click Delete button")
    }))
    
    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
      print("User click Dismiss button")
    }))
    
    self.present(alert, animated: true, completion: {
      print("completion block")
    })*/
  }
  
}


extension ShoppingListViewController: ShoppingListServiceDelegate {
  
  func sendUniqueIdentifier (manager: MCService, identifierForVendor: String, to: MCPeerID) {
    print("identifierForVendor: \(identifierForVendor)")
    mcServiceController.send(identifierForVendor: identifierForVendor, toPeers: to)
  }
  
  
  func presentInvitationAlert (confirm: Bool) {
    
    if confirm == true {
      
      OperationQueue.main.addOperation { () -> Void in
        self.present(self.mcServiceController.alert, animated: true, completion: nil)
      }
    
    }
    
  }
  
  
  func browserViewControllerDidFinish (_ browserViewController: MCBrowserViewController) {
    mcServiceController.mcBrowser.dismiss (animated: true, completion: nil)
  }
  
  
  func browserViewControllerWasCancelled (_ browserViewController: MCBrowserViewController) {
    
    mcServiceController.mcBrowser.dismiss (animated: true, completion: nil)
    mcServiceController.browserSwitcher (activate: false)
    
  }
  
  
  /*func connectedDevicesChanged (manager: MCService, connectedDevices: [String]) {
    
    self.devicesName = connectedDevices
    OperationQueue.main.addOperation {
      self.connectionsLabel.text = "Connections: \(connectedDevices)"
      self.devicesCollection.reloadData()
      print("noc: \(connectedDevices.count)")
    }
    
  }*/
  
  //  func colorChanged(manager: MCService, colorString: String) {
  //    OperationQueue.main.addOperation {
  //      switch colorString {
  //      case "red":
  //        self.change(color: .red)
  //      case "yellow":
  //        self.change(color: .yellow)
  //      default:
  //        NSLog("%@", "Unknown color value received: \(colorString)")
  //      }
  //    }
  //  }
  
}
