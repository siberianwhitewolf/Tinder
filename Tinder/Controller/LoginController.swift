//
//  LoginController.swift
//  Tinder
//
//  Created by Gabriel Fuster on 14/08/2020.
//  Copyright © 2020 Tottem. All rights reserved.
//

import UIKit
import Firebase

class loginController: UIViewController {
    
    //MARK:- Properties
    
    private var viewModel = LoginViewModel()
    
    
    private let iconImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        return iv
        
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecure: true)
    
    private let authButton: AuthButton = {
        let button = AuthButton(title: "Log in", type: .system)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        
        return button
    }()
    
    private let goToRegistrationButton: UIButton = {
        let button = UIButton(type: .system)
        let attributtedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)])
        attributtedTitle.append(NSAttributedString(string: "Sign up", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)]))
        button.setAttributedTitle(attributtedTitle, for: .normal)
        button.addTarget(self, action: #selector(handlesShowRegistration), for: .touchUpInside)
        return button
    }()
    
    //MARK:- Actions
       @objc func handleLogin(){
         guard let email = emailTextField.text else {return}
         guard let password = passwordTextField.text else {return}
        let credentials = LoginCredentials(email: email, password: password)
        AuthService.loginUser(with: credentials) { (result, error) in
            if let error = error {
                print("DEBUG: Error logging user in \(error.localizedDescription)")
                return
            }
            print("DEBUG: Successfully logged in user...")
            self.dismiss(animated: true, completion: nil)
        }
     }
    
    @objc func handlesShowRegistration(){
        navigationController?.pushViewController(registrationController(), animated: true)
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField {
            viewModel.email = sender.text
        }
        else{
            viewModel.password = sender.text
        }
        
        checkFormStatus()
        
    }
    
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        configureUI()
        configureTextFieldObservers()
    }
    
  
    //MARK:- Helpers
    func configureUI()   {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.setDimensions(height: 100, width: 100)
        iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, authButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: iconImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(goToRegistrationButton)
        goToRegistrationButton.anchor(left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingBottom: 16, paddingRight: 32 )
        
    }
    
    func configureTextFieldObservers()  {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    
    func checkFormStatus()  {
        if viewModel.formIsValid {
            authButton.isEnabled = true
            authButton.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        }
        else{
            authButton.isEnabled = false
            authButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
    
}
