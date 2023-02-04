//
//  MessagesFirebaseManager.swift
//  FirebaseChat
//
//  Created by Tolba on 08/07/1444 AH.
//

import Foundation

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class MessagesFirebaseManager {
    
    //MARK:- Properties
    static let shared = MessagesFirebaseManager()
    private static let DBref = Database.database().reference()
    
    //MARK:- initializer
    private init(){}
    
    //MARK:- saveUserInFB
    func saveMessage(content: String, type: String, senderId: String, completion: @escaping ((Error?) -> Void)) {
        let messageData: [String:Any] = [MessageData.senderId: senderId,
                                         MessageData.content: content,
                                         MessageData.date: ServerValue.timestamp(),
                                         MessageData.type: type]
        saveDataMessage(messageData: messageData) { error, data in
            completion(error)
        }
    }
    
    func getMessages(senderId: String, completion: @escaping (([Message]?) -> Void)) {
        var messagesArr: [Message]? = []
        let roomId = getRoomId(senderId: senderId)
        MessagesFirebaseManager.DBref.child(FireBase.messages).child(roomId).observe(.childAdded, with: { snap in
            let userDic = snap.value as? [String:Any] ?? [:]
            messagesArr?.append(self.messageFromDic(dic: userDic as NSDictionary))
            if (messagesArr?.count ?? 0) > 0 {
                completion(messagesArr)
            } else {
                completion(nil)
            }
        })
        completion(nil)
    }
}

//MARK:- Private Functions
extension MessagesFirebaseManager {
    private func saveDataMessage(messageData: [String: Any], completion: @escaping ((Error?,DatabaseReference) -> Void)) {
        let roomId = getRoomId(senderId: messageData[MessageData.senderId] as! String)
        MessagesFirebaseManager.DBref.child(FireBase.messages).child(roomId).childByAutoId().updateChildValues(messageData) { (error, refernce) in
            completion(error,refernce)
        }
    }
    
    private func getRoomId(senderId: String) -> String{
        let currentUserId = UserFireBaseManager.shared.getCurrentUserID() ?? ""
        if senderId.compare(currentUserId).rawValue > 0 {
            return senderId + currentUserId
        } else {
            return currentUserId + senderId
        }
    }
    
    private func messageFromDic(dic: NSDictionary) -> Message {
        let senderId = dic[MessageData.senderId] as! String
        let content = dic[MessageData.content] as! String
        let date = dic[MessageData.date] as? String
        let type = dic[MessageData.type] as! String
        return Message(senderId: senderId, content: content, date: date ?? "", type: type)
    }
}
