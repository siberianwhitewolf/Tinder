//
//  Registration Controller.swift
//  Tinder
//
//  Created by Gabriel Fuster on 14/08/2020.
//  Copyright © 2020 Tottem. All rights reserved.
//
import UIKit
import Firebase

class registrationController: UIViewController {
    
    
    
    
    
    
    
    //MARK:- Properties
    private var viewModel = RegistrationViewModel()
    
    private let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(handleSelectButton), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let fullnameTextField = CustomTextField(placeholder: "Full Name")
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecure: true)
    private var profileImage: UIImage?
    
    private let registerButton: AuthButton = {
        let button = AuthButton(title: "Sign up", type: .system)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let goToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        let attributtedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)])
        attributtedTitle.append(NSAttributedString(string: "Log in", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)]))
        button.setAttributedTitle(attributtedTitle, for: .normal)
        button.addTarget(self, action: #selector(handlesShowLogin), for: .touchUpInside)
        return button
    }()
    
    
    
    
    
    
    
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTextFieldObservers()
    }

    
    
    
    
    //MARK:- Helpers
    
    func configureUI()  {
        configureGradientLayer()
        view.addSubview(selectPhotoButton)
        selectPhotoButton.setDimensions(height: 275, width: 275)
        selectPhotoButton.centerX(inView: view)
        selectPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        let stack = UIStackView(arrangedSubviews: [emailTextField,fullnameTextField, passwordTextField, registerButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: selectPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingRight: 32)
        view.addSubview(goToLoginButton)
        goToLoginButton.anchor(left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingBottom: 16, paddingRight: 32 )
        
    }
    
    
    @objc func handleSelectButton(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleLogin(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = fullnameTextField.text else {return}
        guard let profileImage = self.profileImage else {return}
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, profileImage: profileImage)
        AuthService.registerUser(with: credentials) { error in
            if let error = error {
                print("DEBUG: Error signig user up \(error.localizedDescription)")
                return
            }
            print("DEBUG: Successfully registered user...")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handlesShowLogin(){
         navigationController?.popViewController(animated: true)
     }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField {
            viewModel.email = sender.text
        }
        else if sender == passwordTextField{
            viewModel.password = sender.text
        }
        else{
            viewModel.fullname = sender.text
        }
        checkFormStatus()
        
    }

}

//MARK:- UIImagePickerDelegate

extension registrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        selectPhotoButton.layer.borderWidth = 3
        selectPhotoButton.layer.cornerRadius = 10
        selectPhotoButton.imageView?.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
    
    func configureTextFieldObservers()  {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func checkFormStatus()  {
        if viewModel.formIsValid {
            registerButton.isEnabled = true
            registerButton.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        }
        else{
            registerButton.isEnabled = false
            registerButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
    
}
