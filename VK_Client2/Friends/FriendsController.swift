//
//  FriendsController.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 19.10.2020.
//

import UIKit

class FriendsController: UITableViewController {
    
    let session = Session.instance
    let serv = Services()

    //var friends = UserAcc(friends: ["Василий Пупкин", "Васька Пупкин", "Иван Иванов", "Татьяна Мухина"], images: ["image1", nil, "image2", "image3"], accs: [])
    
    var friends = UserAcc()
    
    var sectionNames = [String]()
    
    var names:[Character: [(String, String?, UIImage?, Int?)]] = ["А":[], "Б":[], "В":[], "Г":[], "Д":[], "Е":[], "Ж":[], "З":[], "И":[], "Й":[], "К":[], "Л":[], "М":[], "Н":[], "О":[], "П":[], "Р":[], "С":[], "Т":[], "У":[], "Ф":[], "Х":[], "Ц":[], "Ч":[], "Ш":[], "Щ":[], "Ы":[], "Э":[], "Ю":[], "Я":[], "A":[], "B":[], "C":[], "D":[], "E":[], "F":[], "G":[], "H":[], "I":[], "J":[], "K":[], "L":[], "N":[], "M":[], "O":[], "P":[], "Q":[], "R":[], "T":[], "S":[], "U":[], "V":[], "W":[], "X":[], "Y":[], "Z":[]]
    
    func abc(words: [String]){
        
        friends.converter(friends: friends.friends, imagesUrls: friends.imagesUrls, images: friends.images, friendsId: friends.friendsId)//create user accs collection
        
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
        
        serv.friendsList(userId: session.userId, token: session.token, v: session.v){ (items) in
            for i in 0...(items.count-1){
                self.friends.friends.insert(items[i].firstName + " " + items[i].lastName, at: i)
                self.friends.imagesUrls.insert(items[i].photoUrl, at: i)
                self.friends.friendsId.insert(items[i].id, at: i)
            }
            for j in 0...(items.count-1){
                let url = URL(string: self.friends.imagesUrls[j]!)
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.friends.images.insert(image, at: j)
                }
            }
            self.abc(words: self.friends.friends)
            self.tableView.reloadData()
        }
        
        
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
        
        let friendAvatar: UIImage? = names[sectionNames[indexPath.section][sectionNames[indexPath.section].startIndex]]?[indexPath.row].2
        
        while friends.friends.count >= likeCount.count{
            likeCount.append(0)
            buttonState.append(false)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        
        cell.configure(title: friend ?? "Deleted", image: friendAvatar ?? UIImage(named: "imageNN"), color: .clear)
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
        destination.friendWatch.friendsId.append(names[sectionNames[tableView.indexPathForSelectedRow!.section][sectionNames[tableView.indexPathForSelectedRow!.section].startIndex]]?[tableView.indexPathForSelectedRow!.row].3)
        //destination.friendWatch.friendsId.append(names[sectionNames[tableView.indexPathForSelectedRow!.section][sectionNames[tableView.indexPathForSelectedRow!.section].startIndex]]?[tableView.indexPathForSelectedRow!.row]. ?? "NaN")
        /*destination.friendWatch.images.append(names[sectionNames[tableView.indexPathForSelectedRow!.section][sectionNames[tableView.indexPathForSelectedRow!.section].startIndex]]?[tableView.indexPathForSelectedRow!.row].1 ?? "NaN")*/
        for i in 0...friends.friends.count - 1{
            if names[sectionNames[tableView.indexPathForSelectedRow!.section][sectionNames[tableView.indexPathForSelectedRow!.section].startIndex]]?[tableView.indexPathForSelectedRow!.row].0 == friends.friends[i]{
                destination.likesCount = i
            }
        }
    }
}
