//
//  CustomTabBarController.swift
//  facebook_newsfeed
//
//  Created by Mospeng Research Lab Philippines on 6/17/20.
//  Copyright © 2020 Mospeng Research Lab Philippines. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1st
        let newsFeedController = NewsFeedCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let newsFeedNavController = UINavigationController(rootViewController: newsFeedController)
        newsFeedNavController.title = "News Feed"
        newsFeedNavController.tabBarItem.image = UIImage(named: "newsfeed_icon")
        
        // 2nd
        let friendRequestsController = FriendRequestsTableViewController()
        let friendRequestsNavController = UINavigationController(rootViewController: friendRequestsController)
        friendRequestsNavController.title = "Requests"
        friendRequestsNavController.tabBarItem.image = UIImage(named: "requests_icon")
        
        // 3rd
        let messengerController = UIViewController()
        messengerController.navigationItem.title = "Messenger"
        messengerController.view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        let messengerNavController = UINavigationController(rootViewController: messengerController)
        messengerNavController.title = "Messenger"
        messengerNavController.tabBarItem.image = UIImage(named: "messenger_icon")
        
        // 4th
        let notificationsController = UIViewController()
        notificationsController.navigationItem.title = "Notifications"
        notificationsController.view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        let notificationsNavController = UINavigationController(rootViewController: notificationsController)
        notificationsNavController.title = "Notifications"
        notificationsNavController.tabBarItem.image = UIImage(named: "notifications_icon")
        
        // 5th
        let moreController = UIViewController()
        moreController.navigationItem.title = "More"
        moreController.view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        let moreNavController = UINavigationController(rootViewController: moreController)
        moreNavController.title = "More"
        moreNavController.tabBarItem.image = UIImage(named: "more_icon")

        
        viewControllers = [newsFeedNavController, friendRequestsNavController, messengerNavController, notificationsNavController, moreNavController]
        
        tabBar.isTranslucent = false
        
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        layer.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235).cgColor
        tabBar.layer.addSublayer(layer)
        tabBar.clipsToBounds = true
        
    }

}
