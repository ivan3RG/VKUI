//
//  UserGroupsTableViewController.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 19.10.2020.
//

import UIKit

class UserGroups:
UITableViewController {
    
    let session = Session.instance
    let serv = Services()
    var userGroupList = Group()
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        tableView.rowHeight = 60
        
        serv.groups(userId: session.userId, token: session.token, v: session.v) { (items) in
            if items.count > 0{
            for i in 0...(items.count-1){
                self.userGroupList.groups.insert(items[i].name, at: i)
            }
            for j in 0...(items.count-1){
                let url = URL(string: items[j].photoUrl)
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.userGroupList.groupsImages.insert((image ?? UIImage(named: "imageNN"))!, at: j)
                }
            }
            }
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userGroupList.groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.configure(title: userGroupList.groups[indexPath.row], image: userGroupList.groupsImages[indexPath.row], color: .clear)
        // Configure the cell...
        return cell
    }

    /*@IBAction func saveData(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "addGroup" else {
            return
        }
        guard let source = unwindSegue.source as? AllGroups else { return }
        if !userGroupList.groups.contains(source.packageText){
            userGroupList.groups.append(source.packageText)
        }
        if !userGroupList.groupsImages.contains(source.packageImage){
            userGroupList.groupsImages.append(source.packageImage)
        }
        tableView.reloadData()
    }*/
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userGroupList.groups.remove(at: indexPath.row)
            userGroupList.groupsImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
