//
//  Service.swift
//  Tinder
//
//  Created by Gabriel Fuster on 15/08/2020.
//  Copyright © 2020 Tottem. All rights reserved.
//

import Foundation
import Firebase

struct service {
    
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        ref.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("DEBUG: Error uplading image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let imageURL = url?.absoluteString else {return}
                completion(imageURL)
                
                
            }
            
            
        }
        
    }
    
    
    
}
