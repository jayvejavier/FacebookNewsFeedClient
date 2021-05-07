//
//  FriendRequestsTableViewController.swift
//  facebook_newsfeed
//
//  Created by Mospeng Research Lab Philippines on 6/17/20.
//  Copyright © 2020 Mospeng Research Lab Philippines. All rights reserved.
//

import Foundation
import UIKit

class FriendRequestsTableViewController: UITableViewController {
    
    static let headerId = "headerId"
    static let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.title = "Friend Requests"
        
        tableView.register(FriendRequestsHeaderView.self, forHeaderFooterViewReuseIdentifier: FriendRequestsTableViewController.headerId)
        tableView.register(FriendRequestsTableViewCell.self, forCellReuseIdentifier: FriendRequestsTableViewController.cellId)
        
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.alwaysBounceVertical = true
        tableView.sectionHeaderHeight = 26
        tableView.rowHeight = 68
        tableView.separatorColor = UIColor.rgb(red: 229, green: 231, blue: 235)
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FriendRequestsTableViewController.headerId) as! FriendRequestsHeaderView
        
        if section == 0 {
            header.headerLabel.text = "FRIEND REQUESTS"
        }
        else {
            header.headerLabel.text = "PEOPLE YOU MAY KNOW"
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendRequestsTableViewController.cellId, for: indexPath) as! FriendRequestsTableViewCell

        if indexPath.item % 3 == 0 {
        cell.requestImageView.image = UIImage(named: "markzuckerberg_profile")
            cell.requestNameLabel.text = "Mark Zuckerberg"
        }
        else if indexPath.item % 3 == 1 {
            cell.requestImageView.image = UIImage(named: "stevejobs_profile")
            cell.requestNameLabel.text = "Steve Jobs"
        }
        else {
            cell.requestImageView.image = UIImage(named: "mahatmagandhi_profile")
            cell.requestNameLabel.text = "Mahatma Gandhi"
        }
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}
