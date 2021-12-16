//
//  SigninViewController.swift
//  Store
//
//  Created by BA Link Ltd on 13/12/2021.
//

import UIKit

class LoginViewController: UIViewController {

    let segueId = "login2categories"
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let userName = usernameTextField.text, let password = passwordTextField.text {
            let auth = Auth()
            auth.login(username: userName, password: password, actionOnResponse: {isValidStatus in
                DispatchQueue.main.async {
                    if isValidStatus {
                        self.errorMessageLabel.text = nil
                        self.performSegue(withIdentifier: self.segueId, sender: self)
                    } else {
                        self.errorMessageLabel.text = "Login failed"
                    }
                }
            })
//            if !Auth.isLoggedIn {
//                errorMessageLabel.text = "Login failed"
//            }
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
