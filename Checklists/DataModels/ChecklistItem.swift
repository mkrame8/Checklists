//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Melanie Kramer on 1/20/21.
//  Copyright © 2021 Melanie Kramer. All rights reserved.
//

import Foundation
import UserNotifications

// class creates objects for the checklist
// conform to codable protocol
class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID = -1
    
    func toggleChecked() {
        checked.toggle()
    }
    
    override init() {
        super.init()
        itemID = DataModel.nextChecklistItemID()
    }
    // compares dueDate with currentDate
    func scheduleNotification() {
        removeNotification()
        if shouldRemind && dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents(
                                                     [.year, .month, .day, .hour, .minute],
                                                     from: dueDate)
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: false)
            let request = UNNotificationRequest(
                identifier: "\(itemID)", content: content,
                trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
            print("Scheduled: \(request) for ItemID: \(itemID)")
        }
    }
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(
            withIdentifiers: ["\(itemID)"])
    }
    deinit {
        removeNotification()
    }
}
