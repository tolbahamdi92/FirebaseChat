//
//  UsersTVC.swift
//  FirebaseChat
//
//  Created by Tolba on 04/07/1444 AH.
//

import UIKit

class UsersTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavUI()
        setupTableViewUI()
    }

}

// MARK: - TableView DataSource
extension UsersTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        return cell
    }
}

//Mark:- Private Functions
extension UsersTVC {
    private func setupNavUI() {
        self.title = ViewControllerTitle.users
    }
    
    private func setupTableViewUI() {
        tableView.separatorStyle = .none
    }
}
