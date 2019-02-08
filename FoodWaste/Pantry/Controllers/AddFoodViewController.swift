//
//  addFoodViewController.swift
//  FoodWaste
//
//  Created by Antonio Biondi on 03/02/2019.
//  Copyright © 2019 Michele Mola. All rights reserved.
//

import UIKit
import AVFoundation
import Speech
import NaturalLanguage

class AddFoodViewController: UITableViewController, UITextFieldDelegate {
  
  private let currentDate = NSDate()  //get the current date
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
  
  private let speechRecognizer = SFSpeechRecognizer()!
  private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
  private var recognitionTask: SFSpeechRecognitionTask?
  private let audioEngine = AVAudioEngine()
  
  private var language = "en"
  
  @IBAction func cancelButton(_ sender: Any) {
    DispatchQueue.main.async {
      self.navigationController?.popViewController(animated: true)
      
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction func doneButton(_ sender: Any) {
    //Da implementare funzione che salva ciò che viene scritto in newFood
    
    // Create Food object to save
    let unit = quantitySegmentedControl.titleForSegment(at: quantitySegmentedControl.selectedSegmentIndex)
    
    DispatchQueue.main.async {
      self.navigationController?.popViewController(animated: true)
      
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction func editingChanged(_ sender: UITextField) {
    validationForm()
  }
  
  func validationForm() {
    doneButton.isEnabled = false
    
    if let name = nameTextField.text, name.count > 0, let quantity = quantityTextField.text, quantity.count > 0, let expirationDate = expirationDayTextField.text, expirationDate.count > 0 {
      doneButton.isEnabled = true
    }
  }
  
  @IBAction func speechButton(_ sender: Any) {
    //Funzione di Michele con AVSpeech Recognition
    if audioEngine.isRunning {
      audioEngine.stop()
      recognitionRequest?.endAudio()
      speechButton.isEnabled = false
      //recordButton.setTitle("Stopping", for: .disabled)
    } else {
      do {
        try startRecording()
        //recordButton.setTitle("Stop Recording", for: [])
      } catch {
        //recordButton.setTitle("Recording Not Available", for: [])
      }
    }
    
    //Funzione che crea cerchio che completa il cerchio grigio, decommentare se la si vuole implementare
//    speechView.addAnimatedWave()
    
    let pulse = createPulse(radius: 130, position: speechButton.center)
    
    if !pulseIsEnabled {
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
    
    if let language = Locale.current.languageCode {
      if language != self.language {
        self.language = language
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    // Configure the SFSpeechRecognizer object already
    // stored in a local member variable.
    speechRecognizer.delegate = self
    
    // Make the authorization request.
    SFSpeechRecognizer.requestAuthorization { authStatus in
      
      // Divert to the app's main thread so that the UI
      // can be updated.
      OperationQueue.main.addOperation {
        switch authStatus {
        case .authorized:
          self.speechButton.isEnabled = true
          
        case .denied:
          self.speechButton.isEnabled = false
          //self.recordButton.setTitle("User denied access to speech recognition", for: .disabled)
          
        case .restricted:
          self.speechButton.isEnabled = false
          //self.recordButton.setTitle("Speech recognition restricted on this device", for: .disabled)
          
        case .notDetermined:
          self.speechButton.isEnabled = false
          //self.recordButton.setTitle("Speech recognition not yet authorized", for: .disabled)
        }
      }
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
    
    var maxLength: Int
    var newString: NSString
    
    if textField == quantityTextField {
      maxLength = 6
      let currentString: NSString = quantityTextField.text! as NSString
      newString = currentString.replacingCharacters(in: range, with: string) as NSString
    }
    else {
      maxLength = 20
      let currentString: NSString = nameTextField.text! as NSString
      newString = currentString.replacingCharacters(in: range, with: string) as NSString
    }
    
    return newString.length <= maxLength
  }
  
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddFoodViewController.dismissKeyboard))
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
  
  func startRecording() throws {
    // Cancel the previous task if it's running.
    if let recognitionTask = recognitionTask {
      recognitionTask.cancel()
      self.recognitionTask = nil
    }
    
    // Configure the audio session for the app.
    let audioSession = AVAudioSession.sharedInstance()
    try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
    try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    let inputNode = audioEngine.inputNode
    
    // Create and configure the speech recognition request.
    recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
    recognitionRequest.shouldReportPartialResults = true
    
    // Create a recognition task for the speech recognition session.
    // Keep a reference to the task so that it can be canceled.
    recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
      var isFinal = false
      
      var text = String()
      
      if let result = result {
        // Update the text view with the results.
        //self.textView.text = result.bestTranscription.formattedString
        text = result.bestTranscription.formattedString
        isFinal = result.isFinal
      }
      
      if error != nil || isFinal {
        // Stop recognizing speech if there is a problem.
        self.audioEngine.stop()
        inputNode.removeTap(onBus: 0)
        
        self.recognitionRequest = nil
        self.recognitionTask = nil
        
        DispatchQueue.main.async {
          self.recognize(text: text)
        }
        
        self.speechButton.isEnabled = true
        //self.recordButton.setTitle("Start Recording", for: [])
        
      }
    }
    
    // Configure the microphone input.
    let recordingFormat = inputNode.outputFormat(forBus: 0)
    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
      self.recognitionRequest?.append(buffer)
    }
    
    audioEngine.prepare()
    try audioEngine.start()
    
    // Let the user know to start talking.
    //textView.text = "(Go ahead, I'm listening)"
  }
  
  func recognize(text: String) {
    
    let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
    tagger.string = text
    
    var words: [String] = []
    
    let range = NSRange(location: 0, length: text.utf16.count)
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
    tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { _, tokenRange, _ in
      let word = (text as NSString).substring(with: tokenRange)
      words.append(word)
    }
    
    populateQuantityAndName(withWords: words)
    
    let df = DateFormatter()
    df.locale = Locale(identifier: self.language)
    df.dateFormat = "LLLL"  // if you need 3 letter month just use "LLL"
    
    if let day = words[safeIndex: 3], let month = words[safeIndex: 2] {
      if let date = df.date(from: month) {
        populateDatePicker(withDay: day, month: month, date: date, andYear: words[safeIndex: 4])
      } else {
        if let date = df.date(from: day) {
          populateDatePicker(withDay: month, month: day, date: date, andYear: words[safeIndex: 4])
        }
      }
    }
    
    validationForm()
    
  }
  
  func populateQuantityAndName(withWords words: [String]) {
    if let qnty = words.first {
      let numberFormatter = NumberFormatter()
      numberFormatter.locale = Locale(identifier: self.language)
      numberFormatter.numberStyle = .spellOut
      
      var numberString = ""
      if let number = numberFormatter.number(from: qnty.lowercased()) {
        numberString = number.stringValue
      } else {
        numberString = qnty
      }
      
      
      DispatchQueue.main.async {
        if Int(numberString) != nil {
          self.quantityTextField.text = numberString
        }
      }
    }
    
    if let name = words[safeIndex: 1] {
      DispatchQueue.main.async {
        self.nameTextField.text = name.capitalized
      }
    }
  }
  
  func populateDatePicker(withDay day: String, month: String, date: Date, andYear year: String?) {
    let month = Calendar.current.component(.month, from: date)
    
    var dateComponents = DateComponents()
    
    dateComponents.year = Calendar.current.component(.year, from: Date())
    
    if let year = year {
      dateComponents.year = Int(year)
    }
    
    dateComponents.day = Int(day)
    dateComponents.month = Int(month)
    
    let calendar = Calendar.current
    if let date = calendar.date(from: dateComponents) {
      DispatchQueue.main.async {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateToString = dateFormatter.string(from: date)

        let currentDate = Date()
        
        if (date > currentDate) {
          self.expirationDayTextField.text = dateToString
        }
      }
    }
  }
  
}

extension AddFoodViewController: SFSpeechRecognizerDelegate {
  public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
    if available {
      speechButton.isEnabled = true
      //recordButton.setTitle("Start Recording", for: [])
    } else {
      speechButton.isEnabled = false
      //recordButton.setTitle("Recognition Not Available", for: .disabled)
    }
  }
}

extension Array {
  public subscript(safeIndex index: Int) -> Element? {
    guard index >= 0, index < endIndex else {
      return nil
    }
    
    return self[index]
  }
}
