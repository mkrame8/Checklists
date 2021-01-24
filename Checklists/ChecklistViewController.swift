//
//  ViewController.swift
//  Checklists
//
//  Created by Melanie Kramer on 1/19/21.
//  Copyright © 2021 Melanie Kramer. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    // array for items
    var items = [ChecklistItem]()
    
    // function will return back to navi controller
    func itemDetailViewControllerDidCancel(
                _ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    // function will add item to end of the array
    // and add a row to the tableview
    func itemDetailViewController(
                _ controller: ItemDetailViewController,
                didFinishAdding item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated:true)
    }
    
    // function will store the new item to the selected cell
    // and return to navi controller
    func itemDetailViewController(
                _ controller: ItemDetailViewController,
                didFinishEditing item: ChecklistItem) {
        if let index = items.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    // load view will set title to large and append these
    // initial checklist items ti items array
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let item1 = ChecklistItem()
        item1.text = "Walk dog"
        items.append(item1)
        
        let item2 = ChecklistItem()
        item2.text = "Brush teeth"
        item2.checked = true
        items.append(item2)
        
        let item3 = ChecklistItem()
        item3.text = "Learn iOS"
        item3.checked = true
        items.append(item3)
        
        let item4 = ChecklistItem()
        item4.text = "Soccer"
        items.append(item4)
        
        let item5 = ChecklistItem()
        item5.text = "Ice cream"
        items.append(item5)
    }
    
    
    // MARK:- Table View Data Source
    // will return the number of rows in the section
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // returns a cell
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // deliver new or recycled cell object to table view
        // when row becomes visible
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Checklistitem",
                for: indexPath)
        
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    // MARK:- Table View Delegate
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        // cellForRow(at: returns an existing cell for
        // row being displayed
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
            }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // function will delete row
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
        // 1
        items.remove(at: indexPath.row)
        
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    // will assign the checkmark symbol, tag 1001, to an item
    // if checked
    func configureCheckmark(for cell: UITableViewCell,
                            with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    
    // will configure the text of a cell
    func configureText(for cell: UITableViewCell,
                       with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }

    
    // MARK:- Navigation
    // function determine if adding or editing item and seque
    // to the correct destination
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination
                            as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination
                            as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(
                                for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }
}

