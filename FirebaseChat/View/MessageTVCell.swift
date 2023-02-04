//
//  MessageTVCell.swift
//  FirebaseChat
//
//  Created by Tolba on 08/07/1444 AH.
//

import UIKit

class MessageTVCell: UITableViewCell {

    enum bubbleType {
        case incoming
        case outgoing
    }

    @IBOutlet weak var chatStack: UIStackView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBubbleView: UIView!
    @IBOutlet weak var senderNameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textViewBubbleView.layer.cornerRadius = 7
        //self.textView.textContainerInset = UIEdgeInsets(top: 0, left: 5, bottom: 20, right: 5)
    }
    
    func configureCell(message: Message){
        self.textView.text = message.content
        UserFireBaseManager.shared.getUser(with: message.senderId) { user in
            self.senderNameLabel.text = user?.name ?? ""
        }
    }

    func setBubbleType(type: bubbleType){
        if(type == .outgoing){
            self.chatStack.alignment = .trailing
            self.textViewBubbleView.backgroundColor = #colorLiteral(red: 0.059805127, green: 0.2340934603, blue: 0.245598033, alpha: 1)
            self.textView.textColor = UIColor.white
            
        } else if(type == .incoming){
            self.chatStack.alignment = .leading
            self.textViewBubbleView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.textView.textColor = UIColor.black
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

