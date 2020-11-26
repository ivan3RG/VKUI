//
//  FriendsController.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 19.10.2020.
//

import UIKit

class FriendsController: UITableViewController {
    
    var sectionCounter: Int = 0

    var friends = UserAcc(friends: ["Василий Пупкин", "Васька Пупкин", "Иван Иванов", "Татьяна Мухина"], images: ["image1", nil, "image2", "image3"])
    
    var names:[Character: [String]] = ["А":[], "Б":[], "В":[], "Г":[], "Д":[], "Е":[], "Ж":[], "З":[], "И":[], "Й":[], "К":[], "Л":[], "М":[], "Н":[], "О":[], "П":[], "Р":[], "С":[], "Т":[], "У":[], "Ф":[], "Х":[], "Ц":[], "Ч":[], "Ш":[], "Щ":[], "Ы":[], "Э":[], "Ю":[], "Я":[], "A":[], "B":[], "C":[], "D":[], "E":[], "F":[], "G":[], "H":[], "I":[], "J":[], "K":[], "L":[], "N":[], "M":[], "O":[], "P":[], "Q":[], "R":[], "T":[], "S":[], "U":[], "V":[], "W":[], "X":[], "Y":[], "Z":[]]
    
    func abc(words: [String]){
        
        for i in 0...(friends.friends.count-1){
            let abc = friends.friends[i]
            names[abc[abc.startIndex]]?.append(friends.friends[i])
            }
        for j in names.values{
            if j.count > 0{
                sectionCounter+=1
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.friends.count
    }
    
    override func viewDidLoad() {
        print(abc(words: friends.friends))
        
        tableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        tableView.rowHeight = 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCounter
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friends.friends[indexPath.row]
        let friendAvatar = friends.images[indexPath.row]
        //imageName = friendAvatar
        
        while friends.friends.count >= likeCount.count{
            likeCount.append(0)
            buttonState.append(false)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        
        cell.configure(title: friend, image: friendAvatar ?? "imageNN", color: .clear)
        cell.textLabel?.textColor = .black
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showFriend", sender: nil)
    }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "showFriend" else { return }
    guard let destination = segue.destination as? FriendCollectionViewController else { return }
        destination.friendWatch.friends.append(friends.friends[tableView.indexPathForSelectedRow!.row])
        destination.friendWatch.images.append(friends.images[tableView.indexPathForSelectedRow!.row])
        destination.likesCount = tableView.indexPathForSelectedRow!.row
    }

}
