//
//  RegistrationController.swift
//  apteka
//
//  Created by Исмаил Ибрагим on 4/16/21.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var password1TextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpPress(_ sender: Any) {
        guard let email = loginTextField.text else { return }
        guard let password = password1TextField.text else { return }
        guard let password2 = password2TextField.text else { return }
        
        if password == password2 {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
                if error == nil {
                    self?.navigationController?.popToRootViewController(animated: true)
                } else {
                    print(error!)
                }
            }
        } else {
            self.present(UIAlertController(title: "Error", message: "Passwords are not the same", preferredStyle: .alert), animated: true, completion: nil)
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
