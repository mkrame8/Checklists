//
//  DataModel.swift
//  Checklists
//
//  Created by Melanie Kramer on 1/31/21.
//  Copyright © 2021 Melanie Kramer. All rights reserved.
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(
                    for: .documentDirectory,
                    in: .userDomainMask)
        return paths[0]
    }
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent(
                                    "Checklists.plist")
    }
    func saveChecklists() {
        let encoder = PropertyListEncoder()
        do {
            // encode the lists
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(),
                           options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array: (error.localizedDescription)")
        
        }
    }
    func loadChecklists() {
        let path = dataFilePath()
        // load contents of checklists.plist
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                // decode to an object of Checklist type to lists
                lists = try decoder.decode([Checklist].self,
                                           from: data)
                sortChecklists()
            } catch {
                print("Error decoding item array: (error.localizedDescription)")
            }
        }
    }
    
    init() {
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
    
    // create new dictionary
    func registerDefaults() {
        let dictionary = ["ChecklistIndex": -1, "FirstTime": true ]
                            as [String : Any]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    // will update UserDefaults
    // computed property
    var indexOfSelectedChecklist: Int {
        // when app reads value of indexOfSelectedChecklist
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        // when app tries to put a new value into indexOfSelectedChecklist
        set {
            UserDefaults.standard.set(newValue,
                                      forKey: "ChecklistIndex")
        }
    }
    // will check value of FirstTime key to check if this is the first
    // time running app. If true, create new CheckList object and add
    // to array. set indexOfSelectedChecklist to 0 so app will segue to new list
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        
        if firstTime {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            
            // set value to false so code will not be executed again
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
    }
    // sort
    func sortChecklists() {
        lists.sort(by: { list1, list2 in
            return list1.name.localizedStandardCompare(list2.name)
                == .orderedAscending })
    }
    // get current checklistitemid value from userdefaults and adds 1
    class func nextChecklistItemID() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "ChecklistItemID")
        userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        return itemID
    }
}
