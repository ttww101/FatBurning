//
//  SignUpFourthViewController.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/28.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit

class ExpectedWeightVC: STBaseVC, UITextFieldDelegate {

    @IBOutlet weak var EWexpectWeightTF: UITextField!
    
    @IBOutlet weak var EWnextBtn: UIButton!
    
    var EWsignupEmail: String?
    
    var EWsignupPassword: String?
    
    var EWuserName: String?
    
    var EWcurrentWeight: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EWexpectWeightTF.delegate = self
        
        EWnextBtn.isEnabled = false
        EWnextBtn.backgroundColor = .B3
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let desVC = segue.destination as? SignUpVC {
            desVC.SUuserName = EWuserName
            desVC.SUcurrentWeight = EWcurrentWeight
            desVC.SUexpectedWeight = EWexpectWeightTF.text!
        }
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
        ) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty {
            EWnextBtn.isEnabled = true
            EWnextBtn.backgroundColor = .B1
        } else {
            EWnextBtn.isEnabled = false
            EWnextBtn.backgroundColor = .B3
        }
        
        return true
        
    }
    
    func customAlert(_ message: String) {
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(alertAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }

}
