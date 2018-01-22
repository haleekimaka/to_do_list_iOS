//
//  AddItemViewController.swift
//  toDoList
//
//  Created by Arin Halicki on 1/22/18.
//  Copyright © 2018 Arin Halicki. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddItemViewController: UIViewController {
    
    weak var delegate: AddItemViewControllerDelegate?
    
    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var itemDescription: UITextField!
    @IBOutlet weak var itemDueDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTitle.placeholder = "Enter Title Here"
        itemDescription.placeholder = "Enter Description Here"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        let text =  itemTitle.text!
        let description = itemDescription.text!
        let pickedDate = itemDueDate.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.string(from: pickedDate)
        delegate?.itemAdded(by: self, with: text, date: date, desc: description)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        delegate?.cancelButtonPressed(by: self)
        
    }
    
}
