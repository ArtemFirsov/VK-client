//
//  GroupsViewController.swift
//  VK-Client
//
//  Created by Artem Firsov on 10/16/21.
//

import UIKit

class GroupsViewController: UITableViewController {

    let apiService = ApiService()
    var groups: [Group] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.reuseIden)
        DispatchQueue.main.async {
            self.apiService.getGroups { [weak self] group in
                guard let self = self else { return }
                self.groups = group
                self.tableView.reloadData()
        }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.reuseIden, for: indexPath) as? FriendCell else { return UITableViewCell() }
        let group = groups[indexPath.row]
        cell.group = group
        cell.configure()
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    

}
