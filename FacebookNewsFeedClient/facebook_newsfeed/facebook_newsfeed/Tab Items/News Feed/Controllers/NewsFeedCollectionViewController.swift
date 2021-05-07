//
//  NewsFeedCollectionViewController.swift
//  facebook_newsfeed
//
//  Created by Mospeng Research Lab Philippines on 6/13/20.
//  Copyright © 2020 Mospeng Research Lab Philippines. All rights reserved.
//

import UIKit

class NewsFeedCollectionViewController: UICollectionViewController {
    
    let cellId = "cellId"
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load status image using default URLCache(URL default cache)
        // Bump up the cache size of URLSession for larger images
        let memoryCapacity = 500 * 1024 * 1024 // 500MBs * 1024KBs * 1024Bs
        let diskCapacity = 500 * 1024 * 1024 // 500MBs * 1024KBs * 1024Bs
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDiskPath")
        URLCache.shared = urlCache
        
        // Use to parse local json file
//        if let path = Bundle.main.path(forResource: "single_post", ofType: "json") {
//
//            do {
//
//                let data = try(NSData(contentsOfFile: path, options: NSData.ReadingOptions.dataReadingMapped))
//
//                let jsonDictionary = try(JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)) as? [String: Any]
//
//                if let postDictionary = jsonDictionary!["post"] as? [String: Any] {
//                    let post = Post()
//                    post.setValuesForKeys(postDictionary)
//
//                    self.posts = [post]
//
//                    print(post.name, post.location?.city, post.location?.state, post.profileImageName, post.statusText, post.statusImageName, post.numLikes, post.numComments, post.statusImageUrl)
//
//                    print(postDictionary)
//                }
//
//                print(jsonDictionary)
//            }
//            catch let err {
//                print(err)
//            }
//        }
        
        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
        postMark.location = Location()
        postMark.location?.city = "San Francisco"
        postMark.location?.state = "CA"
        postMark.profileImageName = "markzuckerberg_profile"
        postMark.statusText = "Meanwhile, Beast turned to dark side."
        postMark.statusImageName = "American_Eskimo_Dog"
        postMark.numLikes = 400
        postMark.numComments = 123
        postMark.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/mark_zuckerberg_background.jpg"

        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.location = Location()
        postSteve.location?.city = "San Cupertino"
        postSteve.location?.state = "CA"
        postSteve.profileImageName = "stevejobs_profile"
        postSteve.statusText = "Design is not just what it looks like and feels like. Design is how it works.\n\n" +
            "Being the richest man in the cemetery doesn’t matter to me. Going to bed at night saying we’ve done something wonderful… that’s what matters to me.\n\n" +
            "Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations."
        postSteve.statusImageName = "Steve_Jobs_presents_iPhone"
        postSteve.numLikes = 1000
        postSteve.numComments = 55
        postSteve.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/steve_jobs_background.jpg"

        let postGandhi = Post()
        postGandhi.name = "Mahatma Gandhi"
        postGandhi.location = Location()
        postGandhi.location?.city = "Porbandar"
        postGandhi.location?.state = "North West IN"
        postGandhi.profileImageName = "mahatmagandhi_profile"
        postGandhi.statusText = "Live as if you were to die tomorrow. Learn as if you were to live forever.\n" +
            "The weak can never forgive. Forgiveness is an attribute of the strong.\n" +
            "Happiness is when what you think, what you say, and what you do are in harmony."
        postGandhi.statusImageName = "The_Collected_Works_of_Mahatma_Gandhi"
        postGandhi.numLikes = 333
        postGandhi.numComments = 22
        postGandhi.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/gandhi_status.jpg"

        posts.append(postMark)
        posts.append(postSteve)
        posts.append(postGandhi)
        
        navigationItem.title = "Facebook Feed"
        
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        collectionView?.register(NewsFeedCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.alwaysBounceVertical = true
    }

    // Transition from Portrait to Landscape, vice-versa
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newsFeedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewsFeedCollectionViewCell
        newsFeedCollectionViewCell.post = posts[indexPath.item]
        newsFeedCollectionViewCell.newsFeedCollectionViewController = self
        return newsFeedCollectionViewCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    let zoomImageView = UIImageView()
    let blackBackgroundView = UIView()
    
    var statusImageView: UIImageView?
    
    func animateImageView(statusImageView: UIImageView) {
        self.statusImageView = statusImageView
        
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            
            // Hides original photo
            statusImageView.alpha = 0

            
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = .black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            zoomImageView.frame = startingFrame
            zoomImageView.backgroundColor = .red
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = statusImageView.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: {
                  self.tabBarController?.tabBar.alpha = 0
                  self.navigationController?.navigationBar.alpha  = 0
                  
                  let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                  let y = self.view.frame.height / 2 - height / 2
                  self.zoomImageView.frame = CGRect(x: 0, y: y, width: startingFrame.width, height: startingFrame.height)
                  
                  self.blackBackgroundView.alpha = 1
            }, completion: nil)
            
        }
    }
    
    @objc func zoomOut() {
        if let startingFrame = statusImageView!.superview?.convert(statusImageView!.frame, to: nil) {
            
            UIView.animate(withDuration: 0.75, animations: {
                self.tabBarController?.tabBar.alpha = 1
                self.navigationController?.navigationBar.alpha  = 1
                
                self.zoomImageView.frame = startingFrame
                self.blackBackgroundView.alpha = 0
            }) { (didComplete) in
        
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.statusImageView?.alpha = 1
            }
        }
    }
    
    
}

extension NewsFeedCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let statusText = posts[indexPath.item].statusText {
            // attributes font needs to match on the element that was declared in the cell
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], context: nil)
            // Formula was based on setupViews(sum of heights and contraints)
            let knownHeight: CGFloat =  8 + 44 + 4 + 4 + 250 + 8 + 24 + 8 + 1 + 44
            // Add + 20 is a trick to have some space at the bottom of textview
            return CGSize(width: view.frame.width, height: rect.height + knownHeight + 20)
        }
        return CGSize(width: view.frame.width, height: 500)
    }
    
    
}
