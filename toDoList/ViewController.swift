//
//  ViewController.swift
//  toDoList
//
//  Created by Arin Halicki on 1/22/18.
//  Copyright © 2018 Arin Halicki. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITableViewController, AddItemViewControllerDelegate{
    
    var listItems = [ToDoListItem]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath) as! CustomTableViewCell
        
        let itemDate = listItems[indexPath.row].date!
        
        cell.title?.text = listItems[indexPath.row].title
        cell.date!.text = String(describing: itemDate)
        cell.descriptionText?.text = listItems[indexPath.row].desc
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = listItems[indexPath.row]
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
        
        listItems.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AddItemViewController
        destination.delegate = self
    }

    func itemAdded(by controller: AddItemViewController, with title: String, date: String, desc: String) {
        
        let item = NSEntityDescription.insertNewObject(forEntityName: "ToDoListItem", into: managedObjectContext) as! ToDoListItem
        
        item.title = title
        item.date = date
        item.desc = desc
        listItems.append(item)

        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }

        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonPressed(by controller: AddItemViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoListItem")
        do {
            let result = try managedObjectContext.fetch(request)
            listItems = result as! [ToDoListItem]
        } catch {
            print(error)
        }
        
    }
    
    
}

