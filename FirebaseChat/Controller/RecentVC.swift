//
//  RecentVC.swift
//  FirebaseChat
//
//  Created by Tolba on 03/07/1444 AH.
//

import UIKit

class RecentVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var messageView: UIView!{
        didSet {
            messageView.layer.cornerRadius = self.messageView.frame.width / 2
        }
    }
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- View Controller Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavUI()
        setupTableViewUI()
    }
    
    //MARK:- IBAction
    @IBAction func messageBtnTapped(_ sender: UIButton) {
        gotoUsersVC()
    }
}

//MARK:- Private functions
extension RecentVC {
    private func setupNavUI() {
        self.title = ViewControllerTitle.recent
    }
    
    private func setupTableViewUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func gotoUsersVC() {
        let usersVC = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(identifier: ViewController.usersTVC)
        self.navigationController?.pushViewController(usersVC, animated: true)
    }
}

//MARK:- TableView DataSource
extension RecentVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

//MARK:- TableView Delegate
extension RecentVC: UITableViewDelegate {
    
}
