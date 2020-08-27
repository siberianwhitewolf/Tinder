//
//  AuthenticationViewMode;.swift
//  Tinder
//
//  Created by Gabriel Fuster on 15/08/2020.
//  Copyright © 2020 Tottem. All rights reserved.
//

import Foundation

protocol AuthenticationViewModel {
    var formIsValid: Bool{ get}
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?

    var formIsValid: Bool{
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    
    
}

struct RegistrationViewModel: AuthenticationViewModel {
    
    var email: String?
    var fullname: String?
    var password: String?
    
    
    var formIsValid: Bool{
        return email?.isEmpty == false && fullname?.isEmpty == false && password?.isEmpty == false
    }
    
}
