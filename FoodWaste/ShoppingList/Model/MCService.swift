//
//  MCService.swift
//  FoodWaste
//
//  Created by alfredo pinfildi on 08/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import Foundation
import MultipeerConnectivity


protocol ShoppingListServiceDelegate: MCBrowserViewControllerDelegate {
  
  //func connectedDevicesChanged(manager: MCService, connectedDevices: [String])
  //  func colorChanged(manager : MCService, colorString: String)
  func sendUniqueIdentifier(manager: MCService, identifierForVendor: String, to: MCPeerID)
  func presentInvitationAlert(confirm: Bool)
  
}





class MCService: NSObject {
  
  // Service type must be a unique string, at most 15 characters long
  // and can contain only ASCII lowercase letters, numbers and hyphens.
  private let ShoppingListServiceType = "shopping-list"
  
  //User's iD
  private let myPeerId = MCPeerID (displayName: UIDevice.current.name)
  private var identifierForVendor: UUID? = UIDevice.current.identifierForVendor
  //You can use either MCNearbyServiceAdvertiser or
  private let serviceAdvertiser: MCNearbyServiceAdvertiser
  //  private var serviceAdvertiserAssistant: MCAdvertiserAssistant!
  public var mcBrowser: MCBrowserViewController!
  //This is the alert popup that appears on a receiver's device when it gets invited to join a session
  var alert: UIAlertController!
  //invitationHandler contains the alert on the alert: Dismiss - Accept (invitation)
  var invitationHandler: ((Bool, MCSession?)->Void)!
  //Used in the main view to know collection view number of cells
  var numberOfConnectedDevices: Int = 0
  //Manages the browser
  private let serviceBrowser: MCNearbyServiceBrowser
  var delegate: ShoppingListServiceDelegate?
  
  lazy var session: MCSession = {
    
    let session = MCSession (peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .required)
    session.delegate = self
    
    return session
  
  }()
  
  
  override init() {
    
    self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: ShoppingListServiceType)
    self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: ShoppingListServiceType)
    
    super.init()
    
    //    self.serviceAdvertiserAssistant = MCAdvertiserAssistant(serviceType: ShoppingListServiceType, discoveryInfo: nil, session: session)
    
    //Start advertising the service to the nearby peers
    self.serviceAdvertiser.delegate = self
    self.serviceBrowser.delegate = self
    //browser starts manually - keep it commented
    //        self.serviceBrowser.startBrowsingForPeers()
    
  }
  
  
  deinit {
    
    //Stop everything when closing
    self.serviceAdvertiser.stopAdvertisingPeer()
    //    self.serviceAdvertiserAssistant.stop()
    self.serviceBrowser.stopBrowsingForPeers()
    
  }
  
  
  func send (identifierForVendor: String, toPeers: MCPeerID) {
    NSLog("%@", "sendColor: \(identifierForVendor) to \(toPeers) peers")
    
    if session.connectedPeers.contains(toPeers) {
      
      do {
        try self.session.send (identifierForVendor.data(using: .utf8)!, toPeers: [toPeers], with: .reliable)
      } catch let error {
        NSLog("%@", "Error for sending: \(error)")
      }
    
    }
    
  }
  
}





// MARK: Service Advertiser
extension MCService: MCNearbyServiceAdvertiserDelegate {
  
  func advertiser (_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
    NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
  }
  
  
  func advertiser (_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping ((Bool, MCSession?) -> Void)) {
    
    NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
    
    //Uncomment if you want the receiver peer to receive an alert invitation
    //    self.invitationHandler = invitationHandler
    //    invitationWasReceived(fromPeer: peerID.displayName)
    
    //Uncomment if you want the receiver peer to automatically accept the invitation
    invitationHandler (true, self.session)
    print("identifierForVendor-: \(String(describing: identifierForVendor))")
    self.delegate?.sendUniqueIdentifier (manager: self, identifierForVendor: identifierForVendor?.uuidString ?? "unidentifiedUUID", to: peerID)
    
  }
  
  
  func invitationWasReceived (fromPeer: String) {
    
    setupInvitationAlert (fromPeer: fromPeer)
    self.delegate?.presentInvitationAlert (confirm: true)
    
  }
  
  
  func setupInvitationAlert (fromPeer: String) {
    
    let alertTitle = ""
    let alertMessage = "\(fromPeer) wants to connect with you."
    
    alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
    
    let acceptAction: UIAlertAction = UIAlertAction (title: "Accept", style: UIAlertAction.Style.default) { (alertAction) -> Void in
      self.invitationHandler(true, self.session)
    }
    
    let declineAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (alertAction) -> Void in
      self.invitationHandler(false, nil)
    }
    
    //Add actions to the alert controller
    alert.addAction(acceptAction)
    alert.addAction(declineAction)
    
  }
  
  
  func startAdvertiser (activate: Bool) {
    
    if activate == true {
      self.serviceAdvertiser.startAdvertisingPeer()
      //      self.serviceAdvertiserAssistant.start()
    } else {
      self.serviceAdvertiser.stopAdvertisingPeer()
      //      self.serviceAdvertiserAssistant.stop()
    }
    
  }
  
}





// MARK: Service Browser
extension MCService: MCNearbyServiceBrowserDelegate {
  
  func browser (_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
    NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
  }
  
  
  func browser (_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
  
    NSLog("%@", "foundPeer: \(peerID)")
    NSLog("%@", "invitePeer: \(peerID)")
    //Automatically invite found peers to join the session
    //    browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
    
  }
  
  
  func browser (_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    NSLog("%@", "lostPeer: \(peerID)")
  }
  
  
  func setupBrowser() {
    mcBrowser = MCBrowserViewController (serviceType: ShoppingListServiceType, session: session)
  }
  
  
  //Methods called from outside to start/stop the browser
  func browserSwitcher (activate: Bool) {
    
    if activate == true {
      self.serviceBrowser.startBrowsingForPeers()
    } else {
      self.serviceBrowser.stopBrowsingForPeers()
    }
    
  }
  
  
  func invitePeer (foundPeer peerID: MCPeerID) {
    
    NSLog("%@", "invitePeer: \(peerID)")
    self.serviceBrowser.invitePeer (peerID, to: self.session, withContext: nil, timeout: 10)
    
  }
  
}





// MARK: Service Session
extension MCService: MCSessionDelegate {
  
  func session (_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    
    NSLog("%@", "peer \(peerID) didChangeState: \(state.rawValue)")
    
    switch state {
      
    case MCSessionState.connected:
      print("Connected: \(peerID.displayName)")
      
    case MCSessionState.connecting:
      print("Connecting: \(peerID.displayName)")
      
    case MCSessionState.notConnected:
      print("Not Connected: \(peerID.displayName)")
    
    }
    
    numberOfConnectedDevices = session.connectedPeers.map{$0.displayName}.count
    //self.delegate?.connectedDevicesChanged (manager: self, connectedDevices: session.connectedPeers.map{$0.displayName})
    
  }
  
  
  func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    
    NSLog("%@", "didReceiveData: \(data)")
    //    let str = String(data: data, encoding: .utf8)!
    //    self.delegate?.colorChanged(manager: self, colorString: str)
    
  }
  
  
  func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    NSLog("%@", "didReceiveStream")
  }
  
  
  func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    NSLog("%@", "didStartReceivingResourceWithName")
  }
  
  
  func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    NSLog("%@", "didFinishReceivingResourceWithName")
  }
  
}

// MARK: Service Miscellaneous

//extension MCService {
//
//  func startHosting(action: UIAlertAction!) {
//    serviceAdvertiserAssistant = MCAdvertiserAssistant(serviceType: ShoppingListServiceType, discoveryInfo: nil, session: session)
//    serviceAdvertiser.startAdvertisingPeer()
////    serviceAdvertiserAssistant.start()
//  }
//
//  func joinSession(action: UIAlertAction!) {
//
//    guard session.connectedPeers.count > 0 else {
//      print("No connected peers")
//      return
//    }
//
//  }
//
//}
