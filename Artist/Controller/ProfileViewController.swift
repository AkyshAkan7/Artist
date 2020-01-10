//
//  ProfileViewController.swift
//  Artist
//
//  Created by Akan Akysh on 12/26/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var quitButton: UIButton!
    fileprivate var listener: AuthStateDidChangeListenerHandle!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authDidChangeListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(listener)
    }
    
    @IBAction func quitButtonPressed(_ sender: Any) {
        try! Auth.auth().signOut()
    }
    
    func setupView() {
        Style.styleBackgroundView(backgroundView)
    }
    
    func authDidChangeListener() {
        listener = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.hideUIElements(false)
                
                UserService.observeUserProfile(user!.uid) { (userProfile) in
                    self.usernameLabel.text = userProfile?.username
                    self.emailLabel.text = userProfile?.email
                }
            } else {
                self.hideUIElements(true)
                self.performSegue(withIdentifier: "GoToAuthorizationVC", sender: nil)
            }
        }
    }
    
    func hideUIElements(_ hide: Bool) {
        quitButton.isHidden = hide
        backgroundView.isHidden = hide
        profileImageView.isHidden = hide
        usernameLabel.isHidden = hide
        emailLabel.isHidden = hide
        warningLabel.isHidden = !hide
    }
    
}
