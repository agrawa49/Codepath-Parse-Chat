//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Abhijeet Chakrabarti on 2/23/17.
//  Copyright © 2017 Abhijeet Chakrabarti. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signUp() {
        let user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        
        user.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                //there is an error
                let errorString = error.localizedDescription
                
                //show the error
                let errorAlertController = UIAlertController(title: "Error!", message: errorString, preferredStyle: .alert)
                let errorAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                    //dismiss
                }
                errorAlertController.addAction(errorAction)
                self.present(errorAlertController, animated: true)
                
            } else {
                //done
                let OKAlertController = UIAlertController(title: "Success!", message: "Sign up successful", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                    //dismiss
                }
                OKAlertController.addAction(OKAction)
                self.present(OKAlertController, animated: true)
            }
        }
    }
    
    func login() {
        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) in
            if let error = error {
                //there is an error
                let errorString = error.localizedDescription
                
                let errorAlertController = UIAlertController(title: "Error!", message: errorString, preferredStyle: .alert)
                let errorAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                    //dismiss
                }
                errorAlertController.addAction(errorAction)
                self.present(errorAlertController, animated: true)
            } else {
                //done
                let OKAlertController = UIAlertController(title: "Success!", message: "Login successful", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let userVC = mainStoryboard.instantiateViewController(withIdentifier: "MessageNavigationController") as! UINavigationController
                    self.present(userVC, animated: true, completion: nil)
                }
                OKAlertController.addAction(OKAction)
                self.present(OKAlertController, animated: true)
            }
        }
    }
    
    @IBAction func onTapSignUp(_ sender: Any) {
        //alert
        let OKAlertController = UIAlertController(title: "Email required", message: "Please enter your email", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            //dismiss
        }
        OKAlertController.addAction(OKAction)
        
        let passwordAlertController = UIAlertController(title: "Password required", message: "Please enter your Password", preferredStyle: .alert)
        let passwordAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            //dismiss
        }
        passwordAlertController.addAction(passwordAction)
        
        if(emailTextField.text == "") {
            present(OKAlertController, animated: true)
        } else if(passwordTextField.text == "") {
            present(passwordAlertController, animated: true)
        }
        
        signUp()
    }
    
    @IBAction func onTapLogin(_ sender: Any) {
        //alert
        let OKAlertController = UIAlertController(title: "Email required", message: "Please enter your email", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            //dismiss
        }
        OKAlertController.addAction(OKAction)
        
        let passwordAlertController = UIAlertController(title: "Password required", message: "Please enter your Password", preferredStyle: .alert)
        let passwordAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            //dismiss
        }
        passwordAlertController.addAction(passwordAction)
        
        if(emailTextField.text == "") {
            present(OKAlertController, animated: true)
        } else if(passwordTextField.text == "") {
            present(passwordAlertController, animated: true)
        }
        
        login()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

