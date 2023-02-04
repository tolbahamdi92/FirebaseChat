//
//  SignUpVC.swift
//  FirebaseChat
//
//  Created by Tolba on 26/06/1444 AH.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var signUpBtnOutlet: UIButton!
    @IBOutlet weak var avatarUser: UIImageView!
    @IBOutlet weak var btnSelectGender: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var signInLB: UILabel!
    @IBOutlet weak var fullNameTF: UITextField! {
        didSet {
            fullNameTF.setImageLeftView(img: Images.name)
        }
    }
    @IBOutlet weak var phoneTF: UITextField! {
        didSet {
            phoneTF.setImageLeftView(img: Images.phone)
        }
    }
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
    private let imagePicker = UIImagePickerController()
    let transparentView = UIView()
    let tableView = UITableView()
    var gender = [Gender.Male.rawValue, Gender.Female.rawValue]
    let imgTappedGesture = UITapGestureRecognizer()
    var gesturSignIn = UITapGestureRecognizer()
    private var indicator = UIActivityIndicatorView()
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK:- IBAction
    @IBAction func onClickSelectGender(_ sender: UIButton) {
        addTransparentView(frames: btnSelectGender.frame)
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        signUpBtnActionTapped()
    }
}

//MARK:- Private Data Functions
extension SignUpVC {
    private func isValidData() -> Bool {
        guard ValidtionDataManager.shared.isValidEmail(email: emailTF.text!) else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.validEmail)
            return false
        }
        guard ValidtionDataManager.shared.isValidPassword(password: passwordTF.text!) else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.validPassword)
            return false
        }
        guard ValidtionDataManager.shared.isValidPhone(phone: phoneTF.text!) else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.validPhone)
            return false
        }
        return true
    }
    
    private func isEnteredData() -> Bool {
        guard avatarUser.image != UIImage(systemName: Images.defaultUserImg) else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noImage)
            return false
        }
        guard fullNameTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noName)
            return false
        }
        guard emailTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noEmail)
            return false
        }
        guard passwordTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noPassword)
            return false
        }
        guard btnSelectGender.titleLabel!.text != ButtonsTitle.gender else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noGender)
            return false
        }
        guard phoneTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noPhone)
            return false
        }
        return true
    }
}

//MARK:- Select Gender Functions
extension SignUpVC {
    private func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.stackView.frame
        self.stackView.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.stackView.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(100))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = btnSelectGender.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
}

//MARK:- Select Image Functions
extension SignUpVC {
    @objc func imageTapped(){
        let alert = UIAlertController(title: Alerts.chooseImage, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: ButtonsTitle.camera, style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: ButtonsTitle.gallary, style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: ButtonsTitle.cancel, style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openGallery() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true)
        } else {
            self.showAlert(title: Alerts.sorryTitle, message: Alerts.cameraNotAccess)
        }
    }
}

//MARK:- Private Functions
extension SignUpVC {
    private func setupUI() {
        self.title = ViewControllerTitle.signUp
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GenderTabelViewCell.self, forCellReuseIdentifier: Cells.genderCell)
        
        btnSelectGender.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7), for: .normal)
        btnSelectGender.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        signInLB.isUserInteractionEnabled = true
        gesturSignIn.addTarget(self, action: #selector(self.goToSignInVC))
        signInLB.addGestureRecognizer(gesturSignIn)
        
        avatarUser.image = UIImage(systemName: Images.defaultUserImg)
        avatarUser.isUserInteractionEnabled = true
        avatarUser.addGestureRecognizer(imgTappedGesture)
        imgTappedGesture.addTarget(self, action: #selector(self.imageTapped))
    }
    
    private func signUpBtnActionTapped() {
        if isEnteredData() && isValidData() {
            self.view.showLoader(indicator: &indicator)
            signUpBtnOutlet.isEnabled = false
            UserFireBaseManager.shared.saveUserInFB(name: fullNameTF.text!, email: emailTF.text!, password: passwordTF.text!, gender: btnSelectGender.titleLabel!.text!, phone: phoneTF.text!, avatar: avatarUser.image!) { error, user in
                if let error = error {
                    self.showAlert(title: Alerts.sorryTitle, message: error.localizedDescription)
                    self.view.hideLoader(indicator: self.indicator)
                    self.signUpBtnOutlet.isEnabled = true
                    return
                } else {
                    self.view.hideLoader(indicator: self.indicator)
                    self.signUpBtnOutlet.isEnabled = true
                    self.gotoApp()
                }
            }
        }
    }
    
    private func gotoApp() {
        let vc = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(identifier: ViewController.usersTVC)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func goToSignInVC(){
        let signInVc = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(identifier: ViewController.signInVC)
        signInVc.modalPresentationStyle = .fullScreen
        signInVc.modalTransitionStyle = .flipHorizontal
        present(signInVc, animated: true, completion: nil)
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension SignUpVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gender.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.genderCell, for: indexPath)
        cell.textLabel?.text = gender[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        btnSelectGender.setTitle(gender[indexPath.row], for: .normal)
        btnSelectGender.setTitleColor(.black, for: .normal)
        btnSelectGender.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        removeTransparentView()
    }
    
}

//MARK:- UIImagePickerControllerDelegate & UINavigationControllerDelegate.
extension SignUpVC: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePicked = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            avatarUser.image = imagePicked.circleMasked
        }
        dismiss(animated: true)
    }
}

