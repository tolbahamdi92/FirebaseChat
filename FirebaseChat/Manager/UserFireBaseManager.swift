//
//  UserFireBaseManager.swift
//  FirebaseChat
//
//  Created by Tolba on 28/06/1444 AH.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class UserFireBaseManager {
    
    //MARK:- Properties
    static let shared = UserFireBaseManager()
    private static let DBref = Database.database().reference()
    
    //MARK:- initializer
    private init(){}
    
    //MARK:- saveUserInFB
    func saveUserInFB(name: String, email: String, password: String, gender: String, phone: String, avatar: UIImage, completion: @escaping ((Error?,User?) -> Void)) {
        createUser(email: email, password: password) { (result, error) in
            if error != nil {
                completion(error, nil)
            } else {
                let user = result!.user
                self.uploadImageData(image: avatar, userId: user.uid, userName: name) { imgurl in
                    let userDic = [UserData.name: name, UserData.gender: gender, UserData.phone: phone, UserData.avatar: imgurl ?? ""]
                    self.saveDataUser(userDic: userDic, userId: user.uid) { (error, refernce) in
                        if error != nil{
                            completion(error, nil)
                        } else {
                            completion(nil,User(name: name, gender: gender, phone: phone, avatar: imgurl ?? ""))
                        }
                    }
                }
            }
        }
    }
    
    func signInFB(email: String, password: String, completion: @escaping ((String?,Error?) -> Void)) {
        signIn(email: email, password: password) { result, error in
            if error != nil {
                completion(nil, error)
            } else {
                let userId = result!.user.uid
                completion(userId,nil)
            }
        }
    }
    
    func getCurrentUserID() -> String? {
        Auth.auth().currentUser?.uid
    }
    
    func getUsers(completion: @escaping (([User]?) -> Void)) {
        var userArr: [User]? = []
        UserFireBaseManager.DBref.child(FireBase.users).observe(.value, with: { snap in
            let sanpShot = snap.value as? [String:Any] ?? [:]
            let snapDic = sanpShot.filter { $0.key != self.getCurrentUserID() ?? ""}.values
            for dic in snapDic{
                userArr?.append(self.userFromDic(dic: dic as! NSDictionary))
            }
            completion(userArr)
        })
    }
}

//MARK:- Private Functions
extension UserFireBaseManager {
    private func createUser(email: String, password: String, completion: @escaping ((AuthDataResult?,Error?) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            completion(result,error)
        }
    }
    
    private func saveDataUser(userDic: [String: Any], userId: String, completion: @escaping ((Error?,DatabaseReference) -> Void)) {
        UserFireBaseManager.DBref.child(FireBase.users).child(userId).setValue(userDic) { (error, refernce) in
            completion(error,refernce)
        }
    }
    
    private func uploadImageData(image: UIImage, userId: String, userName: String, completion: @escaping ((String?) -> ()) ) {
        guard let data = image.jpegData(compressionQuality: 0.7) else {
            completion(nil)
            return
        }
        let storageRef = Storage.storage().reference(forURL: FireBase.urlStorage)
        let fileRef = storageRef.child(FireBase.images).child(userId).child("\(userName)\(FireBase.avatarName)")
        
        _ = fileRef.putData(data, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                completion(nil)
                return
            }
            fileRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    completion(nil)
                    return
                }
                completion(downloadURL.absoluteString)
            }
        }
    }
    
    private func signIn(email: String, password: String, completion: @escaping ((AuthDataResult?,Error?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            completion(result,error)
        }
    }
    
    private func userFromDic(dic: NSDictionary) -> User {
        let name = dic[UserKey.name] as! String
        let gender = dic[UserKey.gender] as! String
        let phone = dic[UserKey.phone] as! String
        let avatar = dic[UserKey.avatar] as! String
        return User(name: name, gender: gender, phone: phone, avatar: avatar)
    }
}
