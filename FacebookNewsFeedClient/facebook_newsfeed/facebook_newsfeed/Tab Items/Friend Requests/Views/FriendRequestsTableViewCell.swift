//
//  FriendRequestsTableViewCell.swift
//  facebook_newsfeed
//
//  Created by Mospeng Research Lab Philippines on 6/18/20.
//  Copyright © 2020 Mospeng Research Lab Philippines. All rights reserved.
//

import UIKit

class FriendRequestsTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let requestImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let requestNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.backgroundColor = UIColor.rgb(red: 87, green: 143, blue: 255)
        button.layer.cornerRadius = 2
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(UIColor(white: 0.3, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.layer.cornerRadius = 2
        button.layer.borderColor = UIColor(white: 0.7, alpha: 1).cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    func setupViews() {
        addSubview(requestImageView)
        addSubview(requestNameLabel)
        addSubview(confirmButton)
        addSubview(deleteButton)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(52)]-8-[v1]-8-|", views: requestImageView, requestNameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(52)]-8-|", views: requestImageView)
    
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-[v1(24)]-8-|", views: requestNameLabel, confirmButton)
        
        // 76 to match in nameLabel
        addConstraintsWithFormat(format: "H:|-76-[v0(80)]-8-[v1(80)]", views: confirmButton, deleteButton)
        
        addConstraintsWithFormat(format: "V:[v0(24)]-8-|", views: deleteButton)
        
    }

}
