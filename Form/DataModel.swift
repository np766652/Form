//
//  DataModel.swift
//  Form
//
//  Created by Nikunjkumar Patel on 06/02/21.
//

import UIKit

class DataModel{
    var fName: String?
    var lName: String?
    var age: Int?
    enum Gender: String, CaseIterable{
        case male
        case female
        case other
    }
    var gender: Gender? = .male
   
    
    
    
}
