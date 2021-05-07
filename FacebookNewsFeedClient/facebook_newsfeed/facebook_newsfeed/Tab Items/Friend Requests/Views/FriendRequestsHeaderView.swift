//
//  FriendRequestsHeaderView.swift
//  facebook_newsfeed
//
//  Created by Mospeng Research Lab Philippines on 6/17/20.
//  Copyright © 2020 Mospeng Research Lab Philippines. All rights reserved.
//

import UIKit

class FriendRequestsHeaderView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(white: 0.4, alpha: 1)
        return label
    }()
    
    let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235)
        return view
    }()
    
    func setupViews() {
        addSubview(headerLabel)
        addSubview(bottomBorderView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: headerLabel)
        addConstraintsWithFormat(format: "V:|[v0][v1(0.5)]|", views: headerLabel, bottomBorderView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: bottomBorderView)
        
    }
    
    
}
