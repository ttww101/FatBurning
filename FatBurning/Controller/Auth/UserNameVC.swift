//
//  SignupSecondViewController.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/27.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit

class UserNameVC: STBaseVC, UITextFieldDelegate {
    
    var UNsignupEmail: String?
    
    var UNsignupPassword: String?
    
    @IBOutlet weak var UNsignupNameTF: UITextField!
    
    @IBOutlet weak var UNnextBtn: UIButton!
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        
        if self.UNsignupNameTF.text == "" {
            self.customAlert("请输入用户名称")
            return
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNsignupNameTF.delegate = self
        
        UNnextBtn.isEnabled = false
        UNnextBtn.backgroundColor = .B3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let desVC = segue.destination as? CurrentWeightVC {
            desVC.CWsignupEmail = UNsignupEmail
            desVC.CWsignupPassword = UNsignupPassword
            desVC.CWuserName = UNsignupNameTF.text
        }
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
        ) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty {
            UNnextBtn.isEnabled = true
            UNnextBtn.backgroundColor = .B1
        } else {
            UNnextBtn.isEnabled = false
            UNnextBtn.backgroundColor = .B3
        }
        
        return true
        
    }
    
    func customAlert(_ message: String) {
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "确定", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(alertAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }

}
