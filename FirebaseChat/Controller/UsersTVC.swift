//
//  UsersTVC.swift
//  FirebaseChat
//
//  Created by Tolba on 04/07/1444 AH.
//

import UIKit
import SDWebImage

class UsersTVC: UITableViewController {
    
    //MARK:- Properities
    var users: [User] = []
    private var indicator = UIActivityIndicatorView()

    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ViewControllerTitle.users
        getCurrentUser()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let messageVC = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(identifier: ViewController.messagesVC) as! MessagesVC
        messageVC.user = users[indexPath.row]
        self.navigationController?.pushViewController(messageVC, animated: true)
    }
    
}

//Mark:- Private Functions
extension UsersTVC {
    private func setupNavUI(currentUser: User){
        let leftView : UIView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
            return view
        }()
        
        let avatar : UIImageView = {
            let image = UIImageView(frame: CGRect(x: 2, y: 7, width: 30, height: 30))
            return image
        }()
        
        let nameLb : UILabel = {
            let name = UILabel(frame: CGRect(x: 35, y: 7, width: 65, height: 30))
            name.textColor = .black
            name.font = UIFont(name: name.font.fontName, size: 20)
            return name
        }()
        
        leftView.addSubview(avatar)
        leftView.addSubview(nameLb)
        nameLb.text = currentUser.name
        nameLb.textAlignment = .left
        avatar.backgroundColor = .clear
        avatar.sd_setImage(with: URL(string: currentUser.avatar), placeholderImage: UIImage(systemName: Images.placeholder))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(signOut))
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
    
    private func getCurrentUser() {
        guard let currentUserID = UserFireBaseManager.shared.getCurrentUserID() else {
            return
        }
        UserFireBaseManager.shared.getUser(with: currentUserID) { user in
            guard let user = user else { return }
            self.setupNavUI(currentUser: user)
        }
    }
    
    @objc func signOut() {
        UserFireBaseManager.shared.signOut { error in
            if let error = error {
                self.showAlert(title: Alerts.sorryTitle, message: error.localizedDescription)
            } else {
                self.goToSignUpVC()
            }
        }
    }
    
    func goToSignUpVC(){
       let signUpVc = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(identifier: ViewController.signUpVC)
        signUpVc.modalPresentationStyle = .fullScreen
        present(signUpVc, animated: true, completion: nil)
    }
}
