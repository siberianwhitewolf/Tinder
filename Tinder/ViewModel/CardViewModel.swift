//
//  CardViewModel.swift
//  Tinder
//
//  Created by Gabriel Fuster on 13/08/2020.
//  Copyright © 2020 Tottem. All rights reserved.
//

import Foundation
import UIKit

struct CardViewModel {
    
    public let user: User
    
    public let userInfoText: NSAttributedString
    
    private var imageIndex: Int = 0
    
    var imageToShow: UIImage
    
    init(user: User) {
        self.user = user
        self.imageToShow = user.images.first!
        
        let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font : UIFont.systemFont(ofSize: 32, weight: .heavy), .foregroundColor: UIColor.white] )
               
        attributedText.append(NSAttributedString(string: "   \(user.age)", attributes: [.font : UIFont.systemFont(ofSize: 24), .foregroundColor: UIColor.white]))
            
        self.userInfoText = attributedText

    }
    
    mutating func showNextPhoto()  {
        if(imageIndex != user.images.endIndex-1){
        imageIndex += 1
            self.imageToShow = user.images[imageIndex]
        }
    }
    
    mutating func showPreviusPhoto()  {
        if(imageIndex != user.images.startIndex){
            imageIndex -= 1
            self.imageToShow = user.images[imageIndex]
        }
    }
    
}
