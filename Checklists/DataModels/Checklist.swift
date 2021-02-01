//
//  Checklist.swift
//  Checklists
//
//  Created by Melanie Kramer on 1/30/21.
//  Copyright © 2021 Melanie Kramer. All rights reserved.
//

import UIKit

// class will create object to hold checklists
class Checklist: NSObject, Codable {
    var name = ""
    var iconName = "No Icon"
    
    // hold ChecklistItem objects and assign to items
    var items = [ChecklistItem]()
    init(name: String, iconName: String = "No Icon") {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    // asks Checklist object how many of its ChecklistItem
    // objects do not have checkmark yet
    func countUncheckedItems() -> Int {
        return items.reduce(0) { cnt,
                                 item in cnt + (item.checked ? 0 : 1)
        }
    }
}
