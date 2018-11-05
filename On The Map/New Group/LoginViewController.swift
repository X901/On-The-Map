//
//  ViewController.swift
//  On The Map
//
//  Created by X901 on 31/10/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTetfield: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewWillDisappear(_ animated: Bool) {
        emailTextfield.text = ""
        passwordTetfield.text = ""

    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        ActivityIndicator.startActivityIndicator(view: self.loginButton)

        guard let username = emailTextfield.text else {return}
        guard let password = passwordTetfield.text else {return}

        let jsonBody = UdacitySessionBody(udacity: Udacity(username: username, password: password))
        
        loginButton.isEnabled = false
        
        OTMUdacityClient.sharedInstance().authenticateWithViewController(self, jsonBody: jsonBody) { (success,errorString) in
            DispatchQueue.main.async {
                if success {
                    self.loginButton.isEnabled = true
                    ActivityIndicator.stopActivityIndicator()
                     self.completeLogin()
                }else {
                    self.loginButton.isEnabled = true
                    ActivityIndicator.stopActivityIndicator()
                    Alert.showBasicAlert(on: self, with: errorString!)
                }
            }
            
        }
    }
    
    
    private func completeLogin() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "ManagerTabBarController") as! UITabBarController
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func signupTapped(_ sender: Any) {
        let url = URL(string: "https://www.udacity.com/account/auth#!/signup")
        guard let newUrl = url else {return}
        let svc = SFSafariViewController(url: newUrl)
        present(svc, animated: true, completion: nil)
    }
    
}

