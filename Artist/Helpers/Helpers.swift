//
//  Helper.swift
//  Artist
//
//  Created by Akan Akysh on 12/14/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import Foundation

class Helpers {
    
    static func timeToMinutes(time: Int) -> String {
        let minutes = time / 1000 / 60
        return String(minutes)
    }
    
    static func timeToSeconds(time: Int) -> String {
        let seconds = time / 1000 % 60
        if seconds < 10 {
            return "0" + String(seconds)
        } else {
            return String(seconds)
        }
    }
    
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9]).{6,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func isEmailValid(_ email: String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
    }
    
    static func validateSignUpFields(email: String, username: String, password: String, secondPassword: String) -> String {
        if !isEmailValid(email) {
            return "Please type correct email"
        }
        
        if password != secondPassword {
            return "Passwords do not match"
        }
        
        if !isPasswordValid(password) {
            return "Please make sure your password is at least 6 character long, contain 1 letter and 1 number"
        }
        
        return ""
    }
    
    static func validateSignInFields(email: String, password: String) -> String {
        if !isEmailValid(email) {
            return "Please type correct email"
        }
        
        if !isPasswordValid(password) {
            return "Please make sure your password is at least 6 character long, contain 1 letter and 1 number"
        }
        
        return ""
    }
    
}
