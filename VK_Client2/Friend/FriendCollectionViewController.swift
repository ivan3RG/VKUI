//
//  FriendCollectionViewController.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 19.10.2020.
//

import UIKit
import SwiftUI

var indexLike = 0
var stateLike = 0

class FriendCollectionViewController: UICollectionViewController {
    
    let session = Session.instance
    let serv = Services()

    var friendWatch = UserAcc()
    var likesCount = 0
    var userImages = [UIImage?]()
    var likes = [Likes?]()
    struct Likes {
        var likesCount: Int = 0
        var isLiked: Int = 0
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionViewCell", for: indexPath) as! FriendCollectionViewCell
            
        indexLike = likesCount
        stateLike = indexLike
        
        cell.photoLabel.text = ("\(friendWatch.friends[0])")
        cell.imageFriend.image = self.userImages[indexPath.row]
       
        cell.like.likeLabel.text = String(self.likes[indexPath.row]?.likesCount ?? 0)
        if (self.likes[indexPath.row]?.isLiked == 0){
            cell.like.heartColor = .blue
            cell.like.fillHeartColor = .white
            cell.like.setupView()
        } else {
            cell.like.heartColor = .red
            cell.like.fillHeartColor = .red
            cell.like.setupView()
        }
        
        return cell
    }

    override func viewDidLoad() {
        serv.photos(userId: String(friendWatch.friendsId[0]!), token: session.token, v: session.v){ (items) in
            for i in 0...items.count-1 {
                self.likes.append(Likes())
                self.likes[i]?.likesCount = items[i].likes.countLikes
                self.likes[i]?.isLiked = items[i].likes.userLikes
                for j in 0...items[i].sizes.count-1{
                    if items[i].sizes[j].type == "p"{
                        let url = URL(string: items[i].sizes[j].url)
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.userImages.append(image)
                }
                }
                }
                
            }
            self.collectionView.reloadData()
    }
        }
    }

