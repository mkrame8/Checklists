//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Melanie Kramer on 1/20/21.
//  Copyright © 2021 Melanie Kramer. All rights reserved.
//

import Foundation

// class creates objects for the checklist
class ChecklistItem: NSObject {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked.toggle()
    }
}
