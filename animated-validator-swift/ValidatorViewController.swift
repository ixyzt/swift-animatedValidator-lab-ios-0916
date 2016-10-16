//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!

    var correctEmail = false
    var correctEmailConfirm = false
    var correctPhone = false
    var correctPass = false
    var correctPassConfirm = false
    var correctSubmit: Bool {
        return correctEmail && correctEmailConfirm && correctPhone && correctPass && correctPassConfirm
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        
        self.submitButton.isEnabled = false
        
        assignDelegates()
        
        self.submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        self.submitButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 100.0).isActive = true
    }
    
    func assignDelegates() {
        self.emailTextField.delegate = self
        self.emailConfirmationTextField.delegate = self
        self.phoneTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordConfirmTextField.delegate = self
    }
    
    func submitAvailable() {
        switch correctSubmit {
        case true:
            self.submitButton.isEnabled = true
            UIView.animate(withDuration: 3, animations: {
                self.submitButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 30).isActive = true
                self.submitButton.layoutIfNeeded()
                }, completion: nil)
        default:
            self.submitButton.isEnabled = false
        }
    }
    
    func animRedPulse (_ textFieldAnim: UITextField) {
        UIView.animate(withDuration: 0.05, animations: {
            textFieldAnim.backgroundColor = UIColor.red
            textFieldAnim.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: { (success) in
                UIView.animate(withDuration:0.2, animations: {
                    textFieldAnim.backgroundColor = UIColor.white
                    textFieldAnim.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            switch (textField.text?.contains("@"))! && (textField.text?.contains("."))! && ((textField.text?.characters.count)! > 0) {
            case true:
                correctEmail = true
                if emailTextField.text != emailConfirmationTextField.text { correctEmailConfirm = false } else { correctEmailConfirm = true }
            default:
                correctEmail = false
                animRedPulse(textField)
            }
            
        case self.emailConfirmationTextField:
            switch emailTextField.text == textField.text {
            case true:
                correctEmailConfirm = true
            default:
                correctEmailConfirm = false
                animRedPulse(textField)
            }
            
        case self.phoneTextField:
            switch ((textField.text!.characters.count) >= 7) && (Int(textField.text!) != nil) && ((textField.text?.characters.count)! > 0) {
            case true:
                correctPhone = true
            default:
                correctPhone = false
                animRedPulse(textField)
            }
            
        case self.passwordTextField:
            switch ((textField.text!.characters.count) >= 6) && ((textField.text?.characters.count)! > 0) {
            case true:
                correctPass = true
                if passwordTextField.text != passwordConfirmTextField.text { correctPassConfirm = false } else { correctPassConfirm = true }
            default:
                correctPass = false
                animRedPulse(textField)
            }
            
        case self.passwordConfirmTextField:
            switch passwordTextField.text == textField.text && ((textField.text?.characters.count)! > 0) {
            case true:
                correctPassConfirm = true
            default:
                correctPassConfirm = false
                animRedPulse(textField)
            }
        default:
            break
        }
        submitAvailable()
    }

}
