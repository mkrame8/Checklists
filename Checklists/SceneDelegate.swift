//
//  SceneDelegate.swift
//  Checklists
//
//  Created by Melanie Kramer on 1/19/21.
//  Copyright © 2021 Melanie Kramer. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let dataModel = DataModel()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // finds AllListsViewController by looking in storyboard
        // and sets its dataModel property so All Lists can access
        // array of Checklist
        let navigationController = window!.rootViewController
                                    as! UINavigationController
        let controller = navigationController.viewControllers[0]
                                    as! AllListsViewController
        controller.dataModel = dataModel
    }

    // save data if scene disconnects
    func sceneDidDisconnect(_ scene: UIScene) {
        saveData()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    // save data if scene enters background
    func sceneDidEnterBackground(_ scene: UIScene) {
        saveData()
    }
    //MARK:- Helper Methods
    // force unwrap optionals
    func saveData() {
        dataModel.saveChecklists()
    }

}

