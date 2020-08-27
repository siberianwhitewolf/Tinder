//
//  AuthService.swift
//  Tinder
//
//  Created by Gabriel Fuster on 15/08/2020.
//  Copyright © 2020 Tottem. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let profileImage:UIImage
}

struct LoginCredentials {
let email: String
let password: String
}

struct AuthService {
    static func registerUser(with credentials: AuthCredentials, completion: @escaping((Error?) -> Void)) {
        service.uploadImage(image: credentials.profileImage) { imageURL in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password){ (result, error) in
                 if let error = error {
                              print("DEBUG: Error signing user up \(error.localizedDescription)")
                              return
                
            }
                guard let uid = result?.user.uid else { return }
            
                let data = ["email": credentials.email, "fullname": credentials.fullname, "image": imageURL,"uid": uid, "age": 18] as [String : Any]
                
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                
                
                
        }
            
         
        
        
    }
}
    
    static func   loginUser(with credentials: LoginCredentials, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: credentials.email, password: credentials.password, completion: completion)
                 }
                 
             }

