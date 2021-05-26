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
        if User.shared.name != "empty" {
            nameTextField.text = User.shared.name
            suremaneTextField.text = User.shared.surename
        }
        
        self.nameTextField.delegate = self
        self.suremaneTextField.delegate = self
            
        }
    
    @IBAction func save(_ sender: Any) {
        User.shared.name = nameTextField.text ?? ""
        User.shared.surename = suremaneTextField.text ?? ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
 

    


