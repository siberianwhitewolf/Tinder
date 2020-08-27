//
//  BottomControlsStackView.swift
//  Tinder
//
//  Created by Gabriel Fuster on 09/08/2020.

import UIKit

class BottomControlsStackView: UIStackView {
    
    
    
    //MARK:- Properties
    
    let refreshButton = UIButton(type: .system)
    let dislikeButton = UIButton(type: .system)
     let superLike = UIButton(type: .system)
     let likeButton = UIButton(type: .system)
     let boostButton = UIButton(type: .system)
    
    //MARK:- Lifecicle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        distribution = .fillEqually
        refreshButton.setImage(#imageLiteral(resourceName: "refresh_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        dislikeButton.setImage(#imageLiteral(resourceName: "dismiss_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        superLike.setImage(#imageLiteral(resourceName: "super_like_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        likeButton.setImage(#imageLiteral(resourceName: "like_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        boostButton.setImage(#imageLiteral(resourceName: "boost_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        
        [refreshButton, dislikeButton, superLike, likeButton, boostButton].forEach { (view) in
            addArrangedSubview(view)
        }
        
   
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}
