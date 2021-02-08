//
//  SecondViewController.swift
//  Form
//
//  Created by Nikunjkumar Patel on 06/02/21.
//

import UIKit

class SecondViewController: UIViewController {



    @IBOutlet weak var labelFName: UILabel!
    @IBOutlet weak var labelLName: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var labelGender: UILabel!

    var dataModel = DataModel()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Details"

    }

    override func viewWillAppear(_ animated: Bool) {
        if let tempFName = dataModel.fName, let tempLName = dataModel.lName, let tempAge = dataModel.age, let tempGender = dataModel.gender
        {
            labelFName.text =  tempFName
            labelLName.text =  tempLName
            labelAge.text = String(tempAge)
            labelGender.text = tempGender.rawValue
        }
        
       
    }
  
}
