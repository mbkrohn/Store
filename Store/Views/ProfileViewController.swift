//
//  ProfileViewController.swift
//  Store
//
//  Created by BA Link Ltd on 13/12/2021.
//

import UIKit

class ProfileViewController: UIViewController {

    let segueId = "profile2Login"
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateLabels()
    }
    

    @IBAction func logoutPressed(_ sender: UIButton) {
        Auth().logout()
        populateLabels()
        performSegue(withIdentifier: segueId, sender: self)
    }
    
    
    func populateLabels(){
        firstNameLabel.text = "First name: \(Auth.firstName)"
        lastNameLabel.text = "Last name: \(Auth.lastName)"
        userNameLabel.text = "User name: \(Auth.userName)"
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
