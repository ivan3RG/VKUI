//
//  FriendsController.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 19.10.2020.
//

import UIKit

class FriendsController: UITableViewController {

    let friends = UserAcc(friends: ["Василий Пупкин", "Иван Иванов", "Татьяна Мухина"], images: ["image1", "image2", "image3"])
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.friends.count
    }
    
    override func viewDidLoad() {
        tableView.rowHeight = 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath)
        let friend = friends.friends[indexPath.row]
        let friendAvatar = friends.images[indexPath.row]
        
        cell.textLabel?.text = friend
        cell.contentView.backgroundColor = .blue
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(named: friendAvatar)
        
        return cell
    }
     
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "showFriend" else { return }
    guard let destination = segue.destination as? FriendCollectionViewController else { return }
        destination.friendWatch.friends.append(friends.friends[tableView.indexPathForSelectedRow!.row])
        destination.friendWatch.images.append(friends.images[tableView.indexPathForSelectedRow!.row])
        
    }

}
