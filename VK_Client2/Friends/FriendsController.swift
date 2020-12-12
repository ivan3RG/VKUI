//
//  FriendsController.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 19.10.2020.
//

import UIKit

class FriendsController: UITableViewController {

    var friends = UserAcc(friends: ["Василий Пупкин", "Васька Пупкин", "Иван Иванов", "Татьяна Мухина"], images: ["image1", nil, "image2", "image3"], accs: [])
    
    var sectionNames = [String]()
    
    var names:[Character: [(String, String?)]] = ["А":[], "Б":[], "В":[], "Г":[], "Д":[], "Е":[], "Ж":[], "З":[], "И":[], "Й":[], "К":[], "Л":[], "М":[], "Н":[], "О":[], "П":[], "Р":[], "С":[], "Т":[], "У":[], "Ф":[], "Х":[], "Ц":[], "Ч":[], "Ш":[], "Щ":[], "Ы":[], "Э":[], "Ю":[], "Я":[], "A":[], "B":[], "C":[], "D":[], "E":[], "F":[], "G":[], "H":[], "I":[], "J":[], "K":[], "L":[], "N":[], "M":[], "O":[], "P":[], "Q":[], "R":[], "T":[], "S":[], "U":[], "V":[], "W":[], "X":[], "Y":[], "Z":[]]
    
    func abc(words: [String]){
        
        friends.converter(friends: friends.friends, images: friends.images)//create user accs collection
        
        for i in 0...(friends.accs.count-1){
            names[friends.accs[i].0[friends.accs[i].0.startIndex]]?.append(friends.accs[i])//add
            }
        for j in names.values{
            
            if j.count > 0{
                var abc = [Character]()
                abc.append(j[0].0[j[0].0.startIndex])
                let title = String(abc)
                sectionNames.append(title)
            }
        }
        sectionNames.sort()
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionNames
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names[sectionNames[section][sectionNames[section].startIndex]]?.count ?? 0
    }
    
    override func viewDidLoad() {
        abc(words: friends.friends)
        
        tableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        tableView.rowHeight = 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = names[sectionNames[indexPath.section][sectionNames[indexPath.section].startIndex]]?[indexPath.row].0
        
        let friendAvatar: String? = names[sectionNames[indexPath.section][sectionNames[indexPath.section].startIndex]]?[indexPath.row].1
        
        while friends.friends.count >= likeCount.count{
            likeCount.append(0)
            buttonState.append(false)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        
        cell.configure(title: friend ?? "Deleted", image: friendAvatar ?? "imageNN", color: .clear)
        cell.textLabel?.textColor = .black
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showFriend", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "showFriend" else { return }
    guard let destination = segue.destination as? FriendCollectionViewController else { return }
        destination.friendWatch.friends.append(names[sectionNames[tableView.indexPathForSelectedRow!.section][sectionNames[tableView.indexPathForSelectedRow!.section].startIndex]]?[tableView.indexPathForSelectedRow!.row].0 ?? "NaN")
        destination.friendWatch.images.append(names[sectionNames[tableView.indexPathForSelectedRow!.section][sectionNames[tableView.indexPathForSelectedRow!.section].startIndex]]?[tableView.indexPathForSelectedRow!.row].1 ?? "NaN")
        for i in 0...friends.friends.count - 1{
            if names[sectionNames[tableView.indexPathForSelectedRow!.section][sectionNames[tableView.indexPathForSelectedRow!.section].startIndex]]?[tableView.indexPathForSelectedRow!.row].0 == friends.friends[i]{
                destination.likesCount = i
            }
        }
    }
}
