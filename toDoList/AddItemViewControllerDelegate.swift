//
//  AddItemViewControllerDelegate.swift
//  toDoList
//
//  Created by Arin Halicki on 1/22/18.
//  Copyright © 2018 Arin Halicki. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemViewControllerDelegate: class {
    func itemAdded(by controller: AddItemViewController, with title: String, date: String, desc: String)
    func cancelButtonPressed(by controller: AddItemViewController)
}
