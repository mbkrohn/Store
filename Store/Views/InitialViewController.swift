//
//  InitialViewController.swift
//  Store
//
//  Created by BA Link Ltd on 13/12/2021.
//

import UIKit

class InitialViewController: UIViewController {

    let segueToLoginId = "initial2Login"
    let segueToregisterId = "initial2register"
    
    @IBOutlet weak var signinPressed: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signinPressed(_ sender: UIButton) {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: false, completion: nil)    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        performSegue(withIdentifier: segueToregisterId, sender: self)
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
