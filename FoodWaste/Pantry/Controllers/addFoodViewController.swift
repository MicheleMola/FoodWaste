//
//  addFoodViewController.swift
//  FoodWaste
//
//  Created by Antonio Biondi on 03/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit
import AVFoundation

class addFoodViewController: UITableViewController, UITextFieldDelegate {
  
  private var datePicker: UIDatePicker?
  var newFood: Food?
  var pulseIsEnabled: Bool = false
  
  @IBOutlet weak var doneButton: UIBarButtonItem!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var quantityTextField: UITextField!
  @IBOutlet weak var expirationDayTextField: UITextField!
  @IBOutlet weak var quantitySegmentedControl: UISegmentedControl!
  @IBOutlet weak var speechView: UIView!
  @IBOutlet weak var speechButton: UIButton!
  @IBOutlet weak var speechLabel: UILabel!
  
  @IBAction func cancelButton(_ sender: Any) {
    DispatchQueue.main.async {
      self.navigationController?.popViewController(animated: true)
      
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction func doneButton(_ sender: Any) {
    //Da implementare funzione che salva ciò che viene scritto in newFood
    
    DispatchQueue.main.async {
      self.navigationController?.popViewController(animated: true)
      
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction func editingChanged(_ sender: UITextField) {
    if nameTextField.text?.count ?? 0 > 0 && quantityTextField.text?.count ?? 0 > 0 && expirationDayTextField.text?.count ?? 0 > 0 {
      doneButton.isEnabled = true
      var segmentedControlText = "pieces"
      switch quantitySegmentedControl.selectedSegmentIndex {
      case 0: segmentedControlText="pieces"
      case 1: segmentedControlText="grams"
      default: segmentedControlText="pieces"
      }
      let quantityText = (quantityTextField.text ?? "0")+segmentedControlText
      
      newFood = Food.init(name: nameTextField.text ?? "Food", quantity: quantityText, expiration: expirationDayTextField.text ?? "Never", image: "Pane")
    }
  }
  
  @IBAction func speechButton(_ sender: Any) {
    //Funzione di Michele con AVSpeech Recognition
    
    //Funzione che crea cerchio che completa il cerchio grigio, decommentare se la si vuole implementare
//    speechView.addAnimatedWave()
    
    let pulse = createPulse(radius: 130, position: speechButton.center)
    
    if pulseIsEnabled==false {
      speechLabel.isHidden = false
      speechView.layer.addSublayer(pulse)
      pulseIsEnabled = true
    }
    else {
      speechLabel.isHidden = true
      speechView.layer.sublayers?.removeLast()
      pulseIsEnabled = false
    }
    
//    speechLabel.isHidden = false
//    addPulse(radius: 130, position: speechButton.center)
    //Quando ascolta cambia colore e inserisce ciò che ascolta
//    speechLabel.textColor = UIColor.black
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Funzione che crea cerchio iniziale intorno al bottone, decommentare se la si vuole implementare
//    speechView.createCircle()
    
    speechLabel.isHidden = true
    doneButton.isEnabled = false
    createDatePicker()
    configureTextFields()
    self.hideKeyboardWhenTappedAround()
  }
  
  func createDatePicker() {
    datePicker = UIDatePicker()
    datePicker?.datePickerMode = .date
    let currentDate = NSDate()  //get the current date
    datePicker?.minimumDate = currentDate as Date  //set the current date/time as a minimum
    datePicker?.date = currentDate as Date
    //maximum time = current time + 120 month
    let maximumDate = (Calendar.current as NSCalendar).date(byAdding: .month, value: 72, to: Date(), options: [])!
    datePicker?.maximumDate = maximumDate
    datePicker?.addTarget(self, action: #selector(addFoodViewController.dateChanged(datePicker:)), for: UIControl.Event.valueChanged)
    
    expirationDayTextField.inputView = datePicker
  }
  
  @objc func dateChanged(datePicker: UIDatePicker) {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    expirationDayTextField.text = dateFormatter.string(from: datePicker.date)
    
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    var result = false
    if textField == quantityTextField {
      let maxLength = 6
      let currentString: NSString = quantityTextField.text! as NSString
      let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
  
      let disallowedCharacterSet = NSCharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz?!@:;-+").inverted
      
      if string.rangeOfCharacter(from: disallowedCharacterSet) != nil && newString.length <= maxLength {
        result = true
      }
    }
    else {
      let maxLength = 20
      let currentString: NSString = nameTextField.text! as NSString
      let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
      
      result = newString.length <= maxLength
    }
    
    return result
  }
  
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addFoodViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
  private func configureTextFields() {
    nameTextField.delegate = self
    quantityTextField.delegate = self
    expirationDayTextField.delegate = self
  }
  
  func createPulse(radius: CGFloat, position: CGPoint) -> Pulsing {
    let pulse = Pulsing(radius: radius, position: position)
    pulse.animationDuration = 2.0
    pulse.backgroundColor = UIColor.red.cgColor
    
   return pulse
  }
  
}
