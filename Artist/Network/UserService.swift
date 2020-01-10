//
//  UserService.swift
//  Artist
//
//  Created by Akan Akysh on 12/27/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import Foundation
import FirebaseFirestore

class UserService {
    
    static func observeUserProfile(_ uid: String, completion: @escaping (_ userProfile: UserProfile?) ->()) {
        let ref = Firestore.firestore().collection("users").document(uid)
        
        ref.getDocument { document, error in
            var userProfile: UserProfile?
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let document = document, document.exists {
                let username = document["username"] as! String
                let email = document["email"] as! String
                
                userProfile = UserProfile(username: username, email: email)
            }
            
            completion(userProfile)
        }
    }
}
