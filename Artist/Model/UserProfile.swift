//
//  UserProfile.swift
//  Artist
//
//  Created by Akan Akysh on 12/27/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import Foundation

struct UserProfile {
    var username: String
    var email: String
    
    
    init(username: String, email: String) {
        self.username = username
        self.email = email
    }
}
