//
//  FriendCollectionViewController.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 19.10.2020.
//

import UIKit

//private let reuseIdentifier = "Cell"

class FriendCollectionViewController: UICollectionViewController {

    var friendWatch = UserAcc()
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionViewCell", for: indexPath) as! FriendCollectionViewCell
        
        cell.photoLabel.text = ("\(friendWatch.friends[indexPath.row]) аватар")
        cell.imageFriend.image = UIImage(named: friendWatch.images[indexPath.row])
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}
