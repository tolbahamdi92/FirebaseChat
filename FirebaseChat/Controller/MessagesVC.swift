//
//  MessagesVC.swift
//  FirebaseChat
//
//  Created by Tolba on 08/07/1444 AH.
//

import UIKit

enum MessageType: String {
    case text
    case image
}

class MessagesVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var containerMessageTF: UIView! {
        didSet {
            containerMessageTF.layer.borderWidth = 2
            containerMessageTF.layer.cornerRadius = containerMessageTF.frame.height / 2
        }
    }
    @IBOutlet weak var sendBtnOutlet: UIButton! {
        didSet {
            sendBtnOutlet.layer.cornerRadius = sendBtnOutlet.frame.height / 2
        }
    }
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Properities
    var user: User?
    var messages: [Message] = []
    private var indicator = UIActivityIndicatorView()
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavUI()
        getMessages()
    }
    
    //MARK:- IBAction
    @IBAction func sendBtnTapped(_ sender: UIButton) {
        sendMesaageActionBtn()
    }
    
}

//MARK:- Pivate Functions
extension MessagesVC {
    private func setupTableViewUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    func setupNavUI(){
        let rightView : UIView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 44))
            return view
        }()
        
        let nameLb : UILabel = {
            let name = UILabel(frame: CGRect(x: 5, y: 0, width: 100, height: 44))
            name.textColor = .black
            name.font = UIFont(name: name.font.fontName, size: 20)
            return name
        }()
        
        let avatar : UIImageView = {
            
            let image = UIImageView(frame: CGRect(x: 110, y: 2, width: 40, height: 40))
            
            return image
        }()
        rightView.addSubview(avatar)
        rightView.addSubview(nameLb)
        nameLb.text = user!.name
        nameLb.textAlignment = .right
        avatar.backgroundColor = .clear
        avatar.sd_setImage(with: URL(string: user!.avatar), placeholderImage: UIImage(systemName: Images.placeholder))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
    }
    
    private func sendMesaageActionBtn() {
        if messageTextField.text != "" {
            self.sendBtnOutlet.isEnabled = false
            MessagesFirebaseManager.shared.saveMessage(content: messageTextField.text!, type: MessageType.text.rawValue, senderId: user?.id ?? "") { error in
                if let error = error {
                    print(error)
                } else {
                    self.messageTextField.text = ""
                }
            }
            self.sendBtnOutlet.isEnabled = true
        }
    }
    
    private func getMessages() {
        self.view.showLoader(indicator: &indicator)
        MessagesFirebaseManager.shared.getMessages(senderId: user!.id) { result in
            self.view.hideLoader(indicator: self.indicator)
            if let messagesArr = result {
                self.messages = messagesArr
                self.tableView.reloadData()
                self.scrollToBottom()
            }
        }
    }
    
    private func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
            if (indexPath.row > 0){
                self.tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
        }
    }
}

//MARK:- TableView DataSource
extension MessagesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.messageTVCell) as! MessageTVCell
        if(UserFireBaseManager.shared.getCurrentUserID() == message.senderId){
            cell.setBubbleType(type: .outgoing)
        } else {
            cell.setBubbleType(type: .incoming)
        }
        cell.configureCell(message: message)
        return cell
    }
    
}

//MARK:- TableView Delegate
extension MessagesVC: UITableViewDelegate {
    //     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        return UIView()
    //    }
    
}
