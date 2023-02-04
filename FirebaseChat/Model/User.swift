//
//  User.swift
//  FirebaseChat
//
//  Created by Tolba on 26/06/1444 AH.
//

import Foundation

enum Gender: String, Codable{
    case Male
    case Female
}

struct User {
    var id: String
    var name: String
    var gender: String
    var phone: String
    var avatar: String
}

