//
//  HomeNavigationStack.swift
//  Tinder
//
//  Created by Gabriel Fuster on 09/08/2020.
//  Copyright © 2020 Tottem. All rights reserved.
//

import UIKit

class HomeNavigationStackView: UIStackView {
    
    
    
    //MARK:- Properties
    
    let settingsButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let tinderIcon = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
    
    
    
    
    
    //MARK:- Lifecicle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        tinderIcon.contentMode = .scaleAspectFit
        settingsButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
        
        [settingsButton, UIView(), tinderIcon, UIView(), messageButton].forEach { (view) in
            addArrangedSubview(view)
        }
        
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    
    
}
