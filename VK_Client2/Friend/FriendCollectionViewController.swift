//
//  FriendCollectionViewController.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 19.10.2020.
//

import UIKit

var indexLike = 0
var stateLike = 0

class FriendCollectionViewController: UICollectionViewController {

    var friendWatch = UserAcc()
    var likesCount = 0
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionViewCell", for: indexPath) as! FriendCollectionViewCell
            
        indexLike = likesCount
        stateLike = indexLike
        
        cell.photoLabel.text = ("\(friendWatch.friends[indexPath.row]) аватар")
        cell.imageFriend.image = UIImage(named: friendWatch.images[indexPath.row] ?? "imageNN")
        if cell.imageFriend.image == UIImage(named: "ImageNN"){
            cell.like.removeFromSuperview()
            return cell
        }
        cell.like.setupView()
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
