//
//  SignUpController.swift
//  Zion Church App
//
//  Created by John-Mark Iliev on 25.12.23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class SignUpController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        errorLabel.alpha = 0
    }
    
    
    // This Method checks the fields and validates if the data is correct/ If it is, then it returns nil. Otherwise, it returns the error message
    
    func validateFields() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please give info in the fields..."
        }
        
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if PasswordManager.isPasswordValid(cleanedPassword) == false {
            
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            // Error in the text fields !
            showError(error!)
            
        } else {
            
            // Create unwrapped versions of the user data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                
                // Check for errors
                if let err = err {
                    
                    // There was an error creating a user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let dataBase = Firestore.firestore()
                    dataBase.collection("users").addDocument(data: ["firstName" : firstName, "lastName" : lastName, "email" : email, "uid" : result!.user.uid]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("User data coudn't be saved")
                        }
                    }
                    // Transition to Home Screen
                    self.transitionToHome()
                    
                }
            }
            
        }
       
    }
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
       let homeViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
