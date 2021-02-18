//
//  AllGroups.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 19.10.2020.
//

import UIKit

class AllGroups: UITableViewController { // Now it's search groups class
    
    let session = Session.instance

    var packageImage = ""
    var packageText = ""
    var serv = Services()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var searched: Bool {
        return searchController.isActive && !searchBarIsEmpty
        }
    
    private var searchedGroups = Group()

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return allGroups.groups.count
        return searchedGroups.groups.count
    }
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        searchController.searchResultsUpdater = self
               searchController.obscuresBackgroundDuringPresentation = false
               searchController.searchBar.placeholder = "Поиск"
               navigationItem.searchController = searchController
               definesPresentationContext = true
        tableView.rowHeight = 60
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.configure(title: searchedGroups.groups[indexPath.row], image: searchedGroups.groupsImages[indexPath.row], color: .clear)
        cell.textLabel?.textColor = .black

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addGroup", sender: nil)
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        packageText = allGroups.groups[tableView.indexPathForSelectedRow!.row]
        packageImage =  allGroups.groupsImages[tableView.indexPathForSelectedRow!.row]
    }*/
}

extension AllGroups: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {

        serv.groupsSearch(userId: session.userId, token: session.token, v: session.v, q: searchController.searchBar.text){ (items) in
            
            if items.count > 0{
            for i in 0...(items.count-1){
                self.searchedGroups.groups.insert(items[i].name, at: i)
            }
            for j in 0...(items.count-1){
                let url = URL(string: items[j].photoUrl)
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.searchedGroups.groupsImages.insert((image ?? UIImage(named: "imageNN"))!, at: j)
                }
            }
            } else if items.count == 0 {
                self.searchedGroups.groups.removeAll()
                self.searchedGroups.groups.removeAll()
            }
            self.tableView.reloadData()
        }
        }
}
