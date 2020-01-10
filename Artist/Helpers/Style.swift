//
//  Style.swift
//  Artist
//
//  Created by Akan Akysh on 12/27/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit

class Style {
    
    static func styleButton(_ button: UIButton) {
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    }
    
    static func styleButtonWithBorder(_ button: UIButton) {
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.borderColor = UIColor.systemPurple.cgColor
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
    }
    
    static func styleBackgroundView(_ view: UIView) {
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}
