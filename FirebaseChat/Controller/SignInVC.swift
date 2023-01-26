//
//  SignInVC.swift
//  FirebaseChat
//
//  Created by Tolba on 03/07/1444 AH.
//

import UIKit

class SignInVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var SignUpLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField! {
        didSet {
            emailTF.setImageLeftView(img: Images.mail)
        }
    }
    @IBOutlet weak var passwordTF: UITextField! {
        didSet {
            passwordTF.setImageLeftView(img: Images.password)
        }
    }
    
    //MARK:- Properities
    var gesturSignIn = UITapGestureRecognizer()
    private var indicator = UIActivityIndicatorView()
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: IBAction
    @IBAction func SignInBtnTapped(_ sender: UIButton) {
        signInBtnActionTapped()
    }
    
}

//MARK: Private Functions
extension SignInVC {
    private func setupUI() {
        self.title = ViewControllerTitle.signUp
        SignUpLabel.isUserInteractionEnabled = true
        gesturSignIn.addTarget(self, action: #selector(self.goToSignUpVC))
        SignUpLabel.addGestureRecognizer(gesturSignIn)
    }
    
    private func signInBtnActionTapped() {
        if isEnteredData() && isValidData() {
            self.view.showLoader(indicator: &indicator)
            UserFireBaseManager.shared.signInFB(email: emailTF.text!, password: passwordTF.text!) { userId, error in
                if let error = error {
                    self.showAlert(title: Alerts.sorryTitle, message: error.localizedDescription)
                    self.view.hideLoader(indicator: self.indicator)
                    return
                } else {
                    self.view.hideLoader(indicator: self.indicator)
                    //self.showAlert(title: Alerts.successTitle, message: Alerts.successSignIn)
                    self.gotoApp()
                }
            }
        }
    }
    
    @objc func goToSignUpVC(){
        dismiss(animated: true, completion: nil)
    }
}

//MARK:- Private Data Functions
extension SignInVC {
    private func isValidData() -> Bool {
        guard ValidtionDataManager.shared.isValidEmail(email: emailTF.text!) else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.validEmail)
            return false
        }
        guard ValidtionDataManager.shared.isValidPassword(password: passwordTF.text!) else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.validPassword)
            return false
        }
        return true
    }
    
    private func isEnteredData() -> Bool {
        
        guard emailTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noEmail)
            return false
        }
        guard passwordTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noPassword)
            return false
        }
        return true
    }
    
    private func gotoApp() {
        let VC = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(identifier: ViewController.recentVC)
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
    }
}
