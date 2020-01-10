//
//  SignUpViewController.swift
//  Artist
//
//  Created by Akan Akysh on 12/26/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import MBProgressHUD

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var secondPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        Style.styleButton(signUpButton)
        errorLabel.isHidden = true
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let secondPassword = secondPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // validate text fields
        let error = Helpers.validateSignUpFields(email: email, username: username, password: password, secondPassword: secondPassword)
        
        if error == "" {
            errorLabel.isHidden = true
            let activityIndicator = MBProgressHUD.showAdded(to: view, animated: true)
            activityIndicator.label.text = "Sign up..."
            activityIndicator.backgroundView.color = .lightGray
            activityIndicator.backgroundView.alpha = 0.5
            
            // create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.showError(error!.localizedDescription)
                    activityIndicator.hide(animated: true)
                    
                    return 
                }
                
                // Save user data to database
                let db = Firestore.firestore()
                db.collection("users").document("\(result!.user.uid)").setData([
                    "username": username,
                    "email": email,
                ]) { (error) in
                    
                    if error != nil {
                        print(error!.localizedDescription)
                        activityIndicator.hide(animated: true)
                        
                        return
                    }
                    
                    activityIndicator.mode = .customView
                    activityIndicator.customView = UIImageView(image: UIImage(named: "Success"))
                    activityIndicator.label.text = "Success"
                    activityIndicator.hide(animated: true, afterDelay: 1.0)
                    
                    DispatchQueue.global(qos: .background).async {
                        // delay for 1 second
                        sleep(1)
                        
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
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
