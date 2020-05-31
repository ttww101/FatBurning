//
//  SignUpThirdViewController.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/27.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit

class CurrentWeightVC: STBaseVC, UITextFieldDelegate {
    
    @IBOutlet weak var CWcurrentWeightTF: UITextField!
    
    @IBOutlet weak var CWnextBtn: UIButton!
    
    var CWsignupEmail: String?
    
    var CWsignupPassword: String?
    
    var CWuserName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CWcurrentWeightTF.delegate = self
        
        CWnextBtn.isEnabled = false
        CWnextBtn.backgroundColor = .B3

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let desVC = segue.destination as? ExpectedWeightVC {
            desVC.EWsignupEmail = CWsignupEmail
            desVC.EWsignupPassword = CWsignupPassword
            desVC.EWuserName = CWuserName
            desVC.EWcurrentWeight = CWcurrentWeightTF.text!
        }
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
        ) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty {
            CWnextBtn.isEnabled = true
            CWnextBtn.backgroundColor = .B1
        } else {
            CWnextBtn.isEnabled = false
            CWnextBtn.backgroundColor = .B3
        }
        
        return true
        
    }
    
}
