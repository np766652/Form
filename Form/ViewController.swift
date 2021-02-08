//
//  ViewController.swift
//  Form
//
//  Created by Nikunjkumar Patel on 05/02/21.
//

import UIKit




class ViewController: UIViewController , UITextFieldDelegate  {
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var tfFName: UITextField!
    @IBOutlet weak var tfLName: UITextField!
    @IBOutlet weak var tfAge: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var allFieldsLabel: UILabel!
    
    let fNameDelegate = UITextField()
    var gendervar: String = ""
    let  dataModel = DataModel()
    let secondVc = SecondViewController()
    enum Gender :String, CaseIterable{
        case male
        case female
        case other
    }
    
    enum ButtonAction: Int, CaseIterable{
        case start = 1
        case nexttoname = 2
        case nextoage = 3
        case submit = 4
    }
    
    enum TextFieldChecker: Int, CaseIterable{
        case fname = 10
        case lname = 11
        case age = 12
    }
    
    
    @IBAction func genderSegment(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            dataModel.gender = .male
        case 1:
            dataModel.gender = .female
        case 2:
            dataModel.gender = .other
        default:
            dataModel.gender = .male
        }
        secondVc.dataModel = dataModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTag()
        self.setDelegate()
        self.navigationItem.title = "Form"
        self.addDoneButtonOnKeyboard()
    }
    
    
    func setTag()
    {
        tfFName.tag = 10
        tfLName.tag = 11
        tfAge.tag = 12
        btnStart.tag = 1
    }
    
    func setDelegate()
    {
        tfFName.delegate = self
        tfLName.delegate = self
        tfAge.delegate = self
    }
    //Cursor Moving Activity
    @IBAction func buttonPressed(_ sender: Any) {
        
        switch btnStart.tag {
        case ButtonAction.start.rawValue:
            tfFName.becomeFirstResponder()
        case ButtonAction.nexttoname.rawValue:
            tfFName.resignFirstResponder()
            tfLName.becomeFirstResponder()
        case ButtonAction.nextoage.rawValue:
            tfLName.resignFirstResponder()
            tfAge.becomeFirstResponder()
        case ButtonAction.submit.rawValue:
            if let storyBoard = self.storyboard {
                let detailViewController = storyBoard.instantiateViewController(identifier: "SecondViewController") as? SecondViewController
                detailViewController?.dataModel = dataModel
                if let detailViewController = detailViewController {
                    if let navigator = navigationController {
                        navigator.pushViewController( detailViewController, animated: true)
                    }
                }
            }
        default:
            print("No Button")
        }
        
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = textField.text as NSString?
        var newString = nsString?.replacingCharacters(in: range, with: string)
        newString = newString?.trimmingCharacters(in: .whitespaces)
        switch textField.tag {
        case TextFieldChecker.fname.rawValue:
            if let stringChecker = newString{
                dataModel.fName = stringChecker
                secondVc.dataModel = dataModel
            }
        case TextFieldChecker.lname.rawValue:
            if let stringChecker = newString{
                dataModel.lName = stringChecker
                secondVc.dataModel = dataModel
            }
        case TextFieldChecker.age.rawValue:
            let allowedCharacters = CharacterSet(charactersIn:"0123456789 ")
            
            if let stringChecker = newString {
                let characterSet = CharacterSet(charactersIn: stringChecker)
                let  limitNumber: Int = Int(stringChecker) ?? -1
                if allowedCharacters.isSuperset(of: characterSet) && limitNumber<=150 {
                    dataModel.age = limitNumber
                    secondVc.dataModel = dataModel
                }else {
                    showToast(controller: self, messgae: "Enter between 0 and 150", seconds: 0.5)
                    return false
                }
            }
        default:
            print("No TextFiled")
        }
        setButtonText()
        return true
    }
    
    
    func setButtonText()
    {
        print(dataModel.age ?? 0)
        if !(dataModel.fName?.isEmpty ?? true) && (dataModel.age ?? -1) != -1 && !(dataModel.lName?.isEmpty ?? true) {
            
            allFieldsLabel.isHidden = true
            btnStart.tag = ButtonAction.submit.rawValue
            btnStart.setTitle("Submit", for: .normal)
        }else if dataModel.fName?.isEmpty ?? true {
            allFieldsLabel.isHidden = false
            btnStart.tag = ButtonAction.start.rawValue
            btnStart.setTitle("Start", for: .normal)
        } else if dataModel.lName?.isEmpty ?? true {
            allFieldsLabel.isHidden = false
            btnStart.tag = ButtonAction.nexttoname.rawValue
            btnStart.setTitle("Next", for: .normal)
        } else {
            allFieldsLabel.isHidden = false
            btnStart.tag = ButtonAction.nextoage.rawValue
            btnStart.setTitle("Next", for: .normal)
        }
    }
    
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        tfFName.inputAccessoryView = doneToolbar
        tfLName.inputAccessoryView = doneToolbar
        tfAge.inputAccessoryView = doneToolbar
    }
    @objc func doneButtonAction(){
        view.endEditing(true)
    }
    
    func showToast(controller: UIViewController, messgae: String, seconds: Double)
    {
        let alert = UIAlertController(title: nil, message: messgae, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.2
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
            alert.dismiss(animated: true)
        }
    }
    
}







    
