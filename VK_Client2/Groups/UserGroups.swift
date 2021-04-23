//
//  UserGroupsTableViewController.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 19.10.2020.
//

import UIKit

var userGroupList = Group()

class UserGroups:
UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userGroupList.groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userGroupCell", for: indexPath)
        let group = userGroupList.groups[indexPath.row]
        cell.textLabel?.text = group
        cell.imageView?.image = UIImage(named: userGroupList.groupsImages[indexPath.row])
        cell.contentView.backgroundColor = .blue
        cell.textLabel?.textColor = .white
        
        // Configure the cell...

        return cell
    }

    @IBAction func saveData(_ unwindSegue: UIStoryboardSegue) {
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
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userGroupList.groups.remove(at: indexPath.row)
            userGroupList.groupsImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
