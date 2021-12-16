//
//  RegisterViewController.swift
//  Store
//
//  Created by BA Link Ltd on 13/12/2021.
//

import UIKit

class RegisterViewController: UIViewController {

    let segueId = "register2categories"
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerPressed(_ sender: UIButton) {
        if let firstname = firstnameTextField.text, let lastname = lastnameTextField.text, let username = usernameTextField.text, let password = passwordTextField.text {
                
            let auth = Auth()
            auth.register(firstName: firstname, lastname: lastname, username: username, password: password, actionOnResponse: {isValidStatus in DispatchQueue.main.async {
                    if isValidStatus {
                        UserDefaults.standard.set(firstname, forKey: Auth.AuthVals.firstname.rawValue)
                        UserDefaults.standard.set(lastname, forKey: Auth.AuthVals.lastname.rawValue)
                        UserDefaults.standard.set(username, forKey: Auth.AuthVals.username.rawValue)
                        self.errorMessageLabel.text = nil
                        self.performSegue(withIdentifier: self.segueId, sender: self)
                    } else {
                        self.errorMessageLabel.text = "Registration failed"
                    }
                }
            })
            
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
