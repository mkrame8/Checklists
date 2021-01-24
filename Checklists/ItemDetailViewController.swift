//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Melanie Kramer on 1/22/21.
//  Copyright © 2021 Melanie Kramer. All rights reserved.
//

import UIKit

// delegate protocols
protocol AddItemViewControllerDelegate: class {
    // protocol for cancel button
    func itemDetailViewControllerDidCancel(
        _ controller: ItemDetailViewController)
    // protocol for done button, adding Item
    func itemDetailViewController(
        _ controller: ItemDetailViewController,
        didFinishAdding item: ChecklistItem)
    // protocol for done button, edit item
    func itemDetailViewController(
        _ controller: ItemDetailViewController,
        didFinishEditing item: ChecklistItem)
}

// delegate class
class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    // class variables
    // weak var can be set to nil
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    weak var delegate: AddItemViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    // load will display clear button mode while editing
    // if there is an item to edit, will assign the textField
    // to variable item
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        textField.clearButtonMode = .whileEditing
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }
    
    // MARK:- Table View Delegates
    // will prevent row turning gray if selected outside
    // textfield area
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath)
        -> IndexPath? {
            return nil
    }
    
    // keyboard will automatically show up when screen is opened
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
    }
    
    // function called everytime user changes the text
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        // determines the new text
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange,
                                                  with: string)
        // if no input in textField, disable done bar
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
        return true
        }
    // disable done button if textfield was cleared
    func textFieldShouldClear(_ textField: UITextField) ->Bool {
        doneBarButton.isEnabled = false
        return true
    }
    
    // MARK:- Actions
    // function for cancel button
    // call method if there's a delegate
    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    // function checks to see if there is an object to edit
    // if yes, function will update object to new item
    // if nil, will create new object
    @IBAction func done() {
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.itemDetailViewController(self,
                        didFinishEditing: item)
        } else {
            let item = ChecklistItem()
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishAdding: item)
    }
}
}
