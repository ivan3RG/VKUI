//
//  AllGroups.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 19.10.2020.
//

import UIKit

class AllGroups: UITableViewController {

    var packageImage = ""
    var packageText = ""
    
    let allGroups = Group(groups: ["Группа раз", "Группа два", "Группа четыре", "Группа тех, кто ищет группу 3"], groupImages: ["image1", "image2", "image3", "image4"])
   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allGroups.groups.count
    }
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        tableView.rowHeight = 60
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        let group = allGroups.groups[indexPath.row]
        cell.configure(title: group, image: allGroups.groupsImages[indexPath.row], color: .clear)
        cell.textLabel?.textColor = .black

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addGroup", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        packageText = allGroups.groups[tableView.indexPathForSelectedRow!.row]
        packageImage =  allGroups.groupsImages[tableView.indexPathForSelectedRow!.row]
    }
    

}
