
//  CustomTextField.swift
//  Tottem
//
//  Created by Gabriel Fuster on 14/08/2020.
//  Copyright © 2020 Tottem. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    

    

    
    init(placeholder: String, isSecure: Bool? = false ) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        keyboardAppearance = .dark
        borderStyle = .none
        textColor = .white
        backgroundColor = UIColor(white: 1, alpha: 0.2)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        layer.cornerRadius = 5
        isSecureTextEntry = isSecure!
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init (coder) has not been implemented.")
    }
}
