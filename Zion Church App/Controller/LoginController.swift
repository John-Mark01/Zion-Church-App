//
//  LoginController.swift
//  Zion Church App
//
//  Created by John-Mark Iliev on 25.12.23.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    func validateFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please give info in the fields..."
        }
        return nil
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        // Validate Text Fields
        let error = validateFields()
        
        if error != nil {
            // Error in the text fields !
            print(error!)
        } else {
            // Create unwrapped versions of the user data
        

        
        // Signing in the User
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                
                // Coudn't sign in
                self.errorLabel.alpha = 1
                self.errorLabel.text = "\(error!.localizedDescription)"
            } else {
                
                let homeViewController =  self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
            
            }
        }
    }
}
