//
//  AuthorizationViewController.swift
//  Artist
//
//  Created by Akan Akysh on 12/26/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        Style.styleButtonWithBorder(signInButton)
        Style.styleButton(signUpButton)
    }

}
