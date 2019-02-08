//
//  PeerCollectionViewCell.swift
//  FoodWaste
//
//  Created by alfredo pinfildi on 02/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit


protocol ShoppingListDelegate {
  
  func showSimpleActionSheet()
  
}


class PeerCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate {
  
  var delegate: ShoppingListDelegate?
  @IBOutlet weak var gradient: UIView!
  @IBOutlet weak var name: UILabel!
  
  @IBAction func addPeer() -> Void {
    
    self.delegate?.showSimpleActionSheet()
    
  }
  
  
  override func awakeFromNib() {
    
    self.gradient.addGradient(colors: [UIColor.black.cgColor, UIColor.white.cgColor], locations: [0.0, 1.0])
    self.contentView.layer.cornerRadius = self.frame.size.width / 2
    self.contentView.layer.masksToBounds = true
  
  }
  
  
  func setUpCell (peer: Peer) {
    
    self.contentView.layer.backgroundColor = peer.color.cgColor
    self.name.text = String(peer.name[0]).uppercased()
    
  }
  
  
  func setUpButton() {
    
    let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height))
    button.setImage(UIImage(named: "add"), for: .normal)
    button.backgroundColor = UIColor.lightGray
    button.addTarget(self, action: #selector(addPeer), for: UIControl.Event.touchUpInside)
    self.contentView.addSubview(button)
    
  }
  
}
