//
//  ViewController.swift
//  12.6
//
//  Created by user on 15.05.21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var suremaneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = User.user.Name
        suremaneTextField.text = User.user.Surename
        self.nameTextField.delegate = self
        self.suremaneTextField.delegate = self
        }
    
    @IBAction func save(_ sender: Any) {
        User.user.Name = nameTextField.text ?? ""
        User.user.Surename = suremaneTextField.text ?? ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
 

    


