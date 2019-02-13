//
//  EditPantryViewController.swift
//  FoodWaste
//
//  Created by Antonio Biondi on 10/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit

class EditPantryViewController: UITableViewController, UITextFieldDelegate  {
  
  private let currentDate = NSDate()  //get the current date
  private var datePicker: UIDatePicker?

  var food: Food?
  
  @IBOutlet weak var foodImage: UIImageView!
  @IBOutlet weak var quantityTextField: UITextField!
  @IBOutlet weak var expirationDayTextField: UITextField!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  @IBAction func cancelButton(_ sender: Any) {
    DispatchQueue.main.async {
      self.navigationController?.popViewController(animated: true)
      
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction func saveButton(_ sender: Any) {
    // Create Food object to save
    
    DispatchQueue.main.async {
      self.navigationController?.popViewController(animated: true)
      
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction func editingChanged(_ sender: UITextField) {
    validationForm()
  }
  
  func validationForm() {
    saveButton.isEnabled = false
    
    if let quantity = quantityTextField.text, quantity.count > 0, let expirationDate = expirationDayTextField.text, expirationDate.count > 0 {
      saveButton.isEnabled = true
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDetailView()
    createDatePicker()
    configureTextFields()
    self.hideKeyboardWhenTappedAround()
  }
  
  func setupDetailView() {
    saveButton.isEnabled = false
    if let food = food {
      self.title = food.name
      quantityTextField.text = food.quantity
      expirationDayTextField.text = food.expiration
      foodImage.image = UIImage(named: food.image)
    }
  }
  
  func createDatePicker() {
    datePicker = UIDatePicker()
    datePicker?.datePickerMode = .date
    datePicker?.minimumDate = currentDate as Date  //set the current date/time as a minimum
    datePicker?.date = currentDate as Date
    //maximum time = current time + 120 month
    let maximumDate = (Calendar.current as NSCalendar).date(byAdding: .month, value: 72, to: Date(), options: [])!
    datePicker?.maximumDate = maximumDate
    datePicker?.addTarget(self, action: #selector(AddFoodViewController.dateChanged(datePicker:)), for: UIControl.Event.valueChanged)
    
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
    
      let maxLength = 6
      let currentString: NSString = quantityTextField.text! as NSString
      let newString = currentString.replacingCharacters(in: range, with: string) as NSString
      return newString.length <= maxLength
  }
  
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditPantryViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
  private func configureTextFields() {
    quantityTextField.delegate = self
    expirationDayTextField.delegate = self
  }
}
