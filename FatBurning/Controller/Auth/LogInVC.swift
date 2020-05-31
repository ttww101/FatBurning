//
//  LogInVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/27.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit


class LogInVC: STBaseVC, UITextFieldDelegate {
    
    @IBOutlet weak var LVloginEmailTF: UITextField!
    
    @IBOutlet weak var LVloginPasswordTF: UITextField!
    
    @IBOutlet weak var LVloginBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LVloginEmailTF.delegate = self
        
        LVloginPasswordTF.delegate = self
        
        LVloginBtn.isEnabled = false
        
        LVloginBtn.backgroundColor = .B3

    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        signIn()
    }
    
    private func signIn() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateInitialViewController()
        
        LeanCloudService.shared.login(LVloginEmailTF.text!, LVloginPasswordTF.text!) { (completion, message) in
            if completion {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateInitialViewController()
            } else {
                let alert = UIAlertController(
                    title: "Error",
                    message: message,
                    preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
            }
        }

//        FIRFirestoreService.shared.login(
//            email: LVloginEmailTF.text!,
//            password: LVloginPasswordTF.text!) { (user, error) in
//                if error != nil {
//                    let alert = UIAlertController(
//                        title: "Error",
//                        message: error?.localizedDescription,
//                        preferredStyle: .alert)
//                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                    alert.addAction(defaultAction)
//                    self.present(alert, animated: true, completion: nil)
//                }
//        }
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
        ) -> Bool {
        
        if textField == LVloginPasswordTF {
            
            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            
            if !text.isEmpty {
                LVloginBtn.isEnabled = true
                LVloginBtn.backgroundColor = .Orange
            } else {
                LVloginBtn.isEnabled = false
                LVloginBtn.backgroundColor = .B3
            }
            
        }
        
        if textField == LVloginEmailTF {
            
            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            
            if !text.isEmpty {
                LVloginBtn.isEnabled = true
                LVloginBtn.backgroundColor = .Orange
            } else {
                LVloginBtn.isEnabled = false
                LVloginBtn.backgroundColor = .B3
            }
            
        }
        
        return true
    }

}
