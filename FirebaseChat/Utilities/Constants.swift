//
//  Constants.swift
//  FirebaseChat
//
//  Created by Tolba on 28/06/1444 AH.
//

import Foundation

//MARK:- StoryBoard
struct StoryBoard {
    static let main = "Main"
}

//MARK:- FireBase
struct FireBase {
    static let urlStorage = "gs://fir-chat-1c0b8.appspot.com"
    static let images = "images"
    static let avatarName = "Avatar.jpeg"
    static let users = "Users"
}

//MARK:- UserData
struct UserData {
    static let name = "name"
    static let gender = "gender"
    static let phone = "phone"
    static let avatar = "avatar"
}

//MARK:- ViewController
struct ViewController {
    static let signUpVC = "SignUpVC"
    static let signInVC = "SignInVC"
    static let recentVC = "RecentVC"
    static let usersTVC = "UsersTVC"
}

//MARK:- ViewControllerTitle
struct ViewControllerTitle {
    static let signUp = "Sign Up"
    static let userDataEditing = "User Data"
    static let signIn = "Sign In"
    static let recent = "Recent Messages"
    static let users = "Users"
}

//MARK:- UserDefaultsKeys
struct UserDefaultsKeys {
    static let isLoggedIn = "isLoggedIn"
    static let email = "email"
}

//MARK:- Cells
struct Cells {
    static let genderCell: String = "Cell"
}

//MARK:- ButtonsTitle
struct ButtonsTitle {
    static let signUp = "Sign Up"
    static let saveData = "Save Data"
    static let logOut = "Log out"
    static let profile = "Profile"
    static let ok = "OK"
    static let camera = "Camera"
    static let gallary = "Gallery"
    static let cancel = "Cancel"
    static let gender = "Select Gender"
}

//MARK:- Images
struct Images {
    static let name: String = "name"
    static let phone: String = "phone"
    static let mail: String = "mail"
    static let password: String = "password"
    static let defaultUserImg = "person.circle"
}

//MARK:- ValidationRegex
struct ValidationRegex {
    static let formate = "SELF MATCHES %@"
    static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9._]+\\.[A-Za-z]{2,}"
    static let password = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
    static let phone = "^[0-9]{11}$"
}

//MARK:- Alerts
struct Alerts {
    static let sorryTitle = "Sorry"
    static let chooseImage = "Choose Image"
    static let successTitle = "Success"
    static let validEmail = " Please enter valid email \n Example tolba@gmail.com"
    static let validPassword = "Please enter valid password \n contains at least one upper character \n contains at least one small character \n contain at least one number \n At least total 8 character"
    static let validPhone = "Please enter valid phone \n Example 01055555555"
    static let noImage = "Please choose your photo"
    static let noName = "Please enter your name"
    static let noEmail = "Please enter your email"
    static let noPassword = "Please enter your password"
    static let noPhone = "Please enter your phone"
    static let noGender = "Please choose your gender"
    static let noAddress = "Please enter your address"
    static let noFoundData = "No Found Data"
    static let noSearchData = "please enter data in search"
    static let moreCharacterSearch = "please enter at least 3 characters"
    
    static let dataLoginWrong = "email or password is wrong"
    static let cameraNotAccess = "Camera not allowed access"
    
    static let tryAgain = "Possibly something is wrong try again"
    
    static let disableLocation = "Your location is disable. \nPlease enable it"
    static let deniedLocationService = "I can not get location . \nI hope to accept access your location"
    
    static let successSignUp = "Sign Up successfully"
    static let successSignIn = "Sign In successfully"
    
}
