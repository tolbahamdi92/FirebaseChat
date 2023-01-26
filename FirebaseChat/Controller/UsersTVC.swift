//
//  UsersTVC.swift
//  FirebaseChat
//
//  Created by Tolba on 04/07/1444 AH.
//

import UIKit
import SDWebImage

class UsersTVC: UITableViewController {
    
    var users: [User] = []
    private var indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getUsers()
    }

}

// MARK: - TableView DataSource
extension UsersTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.usersCell, for: indexPath) as! UsersTVCell
        cell.configCell(user: users[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - TableView Delegate
extension UsersTVC {
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

//Mark:- Private Functions
extension UsersTVC {
    private func setupNavUI() {
        self.title = ViewControllerTitle.users
    }
    
    private func getUsers() {
        self.view.showLoader(indicator: &indicator)
        UserFireBaseManager.shared.getUsers { result in
            if let usersArr = result {
                self.users = usersArr
                self.view.hideLoader(indicator: self.indicator)
                self.tableView.reloadData()
            } else {
                self.view.hideLoader(indicator: self.indicator)
            }
        }
    }
}
