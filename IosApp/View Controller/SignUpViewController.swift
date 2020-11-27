//
//  SignUpViewController.swift
//  IosApp
//
//  Created by Clémence Beyrie on 25/11/2020.
//

import UIKit
import FirebaseAuth
import Firebase


class SignUpViewController: UIViewController {

    @IBOutlet weak var FirstNameTextField: UITextField!
    
    @IBOutlet weak var LastNameTextField: UITextField!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextFiled: UITextField!
    
    @IBOutlet weak var SignUpBtn: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupElements()
    }
    
    func setupElements() {
        ErrorLabel.alpha = 0
    }
    func validateFields() -> String? {
       
        if FirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextFiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        let cleanedPassword = PasswordTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanedPassword) {
            
        } else {
            return "Password isn't secure enough"
        }
        
        return nil
    }
    
    @IBAction func SignUpTapped(_ sender: Any) {
        
        //Validate fields and create user
        let error = validateFields()
        
        if error != nil {
            
            // something wrong, show message
            showError(error!)
            
        } else {
            
            let firstname = FirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = LastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    self.showError("Error creating useer")
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        "firstname": firstname,
                        "lastname": lastName,
                        "uid": result!.user.uid
                    ]) { err in
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                    }
                    self.transitionToHome()
                }
                
            }
        }
        
    }
    func transitionToHome() {
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
    func showError(_ message : String) {
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    

}
