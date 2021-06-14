//
//  LoginController.swift
//  apteka
//
//  Created by Исмаил Ибрагим on 4/16/21.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        guard let email = loginField.text else { return }
        guard let password = passwordField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if error == nil {
                let vcProd=self?.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                self?.navigationController?.pushViewController(vcProd, animated: true)
            } else {
                print(error!)
            }
        }
    }
    
    @IBAction func signUpPress(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegistrationController") as! RegistrationController
         
    
        navigationController?.pushViewController(vc, animated: true)
    }

}
