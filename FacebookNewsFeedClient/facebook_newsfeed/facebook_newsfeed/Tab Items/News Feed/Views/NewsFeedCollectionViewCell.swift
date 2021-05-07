//
//  NewsFeedCollectionViewCell.swift
//  facebook_newsfeed
//
//  Created by Mospeng Research Lab Philippines on 6/13/20.
//  Copyright © 2020 Mospeng Research Lab Philippines. All rights reserved.
//

//import Foundation
import UIKit

class NewsFeedCollectionViewCell: UICollectionViewCell {
    
    var newsFeedCollectionViewController: NewsFeedCollectionViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Test if tap gesture is working at the first place
//    @objc func animate() {
//       let view = UIView()
//       view.backgroundColor = .black
//       view.frame = statusImageView.frame
//       addSubview(view)
//    }
    
    @objc func animate() {
        newsFeedCollectionViewController?.animateImageView(statusImageView: statusImageView)
    }
    
    var post: Post? {
        didSet {
            statusImageView.image = nil

            // Load status image from Assets.xcassets
            if let statusImageName = post?.statusImageName {
                statusImageView.image = UIImage(named: statusImageName)
            }

            // Load status image using URLRequest
//            setStatusImageFromURLRequest()
            
            // Load status image using URLRequest and NSCache
//            setStatusImageFromURLRequestWithNSCache()
        
            setupNameLocationStatusAndProfileImage()
        }
    }

    func setupNameLocationStatusAndProfileImage() {
        if let profileImageName = post?.profileImageName {
            profileImageView.image = UIImage(named: profileImageName)
        }

        if let name = post?.name {
            let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])

            if let location = post?.location {
                attributedText.append(NSAttributedString(string: "\nDecember 18  •  \(location.city ?? "") \(location.state ?? "")  •  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 155, green: 161, blue: 171)]))

                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))

                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "globe_icon")
                attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                attributedText.append(NSAttributedString(attachment: attachment))
            }

            nameLabel.attributedText = attributedText
        }

        if let statusText = post?.statusText {
            statusTextView.text = statusText
        }

        if let numLikes = post?.numLikes, let numComments = post?.numComments {
            likesCommentsLabel.text = "\(numLikes) Likes     \(numComments) Comments"
        }
    }
    
    func setStatusImageFromURLRequest(){
        if let statusImageUrl = post?.statusImageUrl {
            guard let url = URL(string: statusImageUrl) else { return }
            URLSession.shared.dataTask(with: url) { (data, _, error) in

                if error != nil {
                    print(error!)
                    return
                }
                let image = UIImage(data: data!)

                DispatchQueue.main.async {
                    self.statusImageView.image = image
                }
            }.resume()
        }
    }
    
    func setStatusImageFromURLRequestWithNSCache(){
        if let statusImageUrl = post?.statusImageUrl {

            if let image = imageCache.object(forKey: statusImageUrl as AnyObject) {
                statusImageView.image = image
            }
            else {
                guard let url = URL(string: statusImageUrl) else { return }
                URLSession.shared.dataTask(with: url) { (data, _, error) in

                    if error != nil {
                        print(error!)
                        return
                    }

                    let image = UIImage(data: data!)
                    imageCache.setObject(image!, forKey: statusImageUrl as AnyObject)

                    DispatchQueue.main.async {
                        self.statusImageView.image = image
                    }
                }.resume()
            }
        }
    }

    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    let blockButton = NewsFeedCollectionViewCell.buttonForTitle(title: "Block", imageName: "block_icon")

    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()

    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 0.16
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        return label
    }()

    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()

    static func buttonForTitle(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        // To apply button.barTintColor use withRenderingMode
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.tintColor = UIColor.rgb(red: 143, green: 150, blue: 163)
//        button.layer.borderColor = UIColor.black.cgColor
//        button.layer.borderWidth = 1
        return button
    }

    let buttonsContainerView: UIView = {
        let view = UIView()

        let likeButton = NewsFeedCollectionViewCell.buttonForTitle(title: "Like", imageName: "like_icon")
        let commentButton = NewsFeedCollectionViewCell.buttonForTitle(title: "Comment", imageName: "comment_icon")
        let shareButton = NewsFeedCollectionViewCell.buttonForTitle(title: "Share", imageName: "share_icon")

        view.addSubview(likeButton)
        view.addSubview(commentButton)
        view.addSubview(shareButton)

        // For two elements equality
//        addConstraintsWithFormat(format: "H:|[v0(v1)][v1]|", views: likeButton, commentButton)
        // For three elements equality
        view.addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        view.addConstraintsWithFormat(format: "V:|[v0(44)]|", views: likeButton)
        view.addConstraintsWithFormat(format: "V:|[v0(44)]|", views: commentButton)
        view.addConstraintsWithFormat(format: "V:|[v0(44)]|", views: shareButton)
        return view
    }()

    func setupViews() {
        backgroundColor = .white
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(blockButton)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)
        addSubview(buttonsContainerView)
        
        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))

        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1][v2(70)]-8-|", views: profileImageView, nameLabel, blockButton)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentsLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: buttonsContainerView)

        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|[v0(30)]", views: blockButton)
        //textview(v1) takes up the remainder space for all the space just left over for the entire cell, while everything is a static height
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(250)]-8-[v3(24)]-8-[v4(1)][v5]|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel, dividerLineView, buttonsContainerView)
    }
}


