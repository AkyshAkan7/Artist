//
//  SignInViewController.swift
//  Artist
//
//  Created by Akan Akysh on 12/26/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit
import FirebaseAuth
import MBProgressHUD

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        errorLabel.isHidden = true
        Style.styleButton(signInButton)
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // validate text fields
        let error = Helpers.validateSignInFields(email: email, password: password)
        
        if error == "" {
            errorLabel.isHidden = true
            let activityIndicator = MBProgressHUD.showAdded(to: view, animated: true)
            activityIndicator.label.text = "Sign in..."
            activityIndicator.backgroundView.color = .lightGray
            activityIndicator.backgroundView.alpha = 0.5
            
            // login user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.showError(error!.localizedDescription)
                    activityIndicator.hide(animated: true)
                    
                    return
                }
                activityIndicator.hide(animated: true)
                
                DispatchQueue.global(qos: .background).async {
                    // delay for 0.5 seconds
                    usleep(500000)
                    
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
            
        } else {
            showError(error)
        }
    }
    
    func showError(_ text: String) {
        errorLabel.isHidden = false
        errorLabel.text = text
    }
    
}
