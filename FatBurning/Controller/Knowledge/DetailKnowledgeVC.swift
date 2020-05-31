//
//  DetailKnowledgeVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/8.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit

class DetailKnowledgeVC: UIViewController {
    
    @IBOutlet weak var DKtitleLabel: UILabel!
    
    @IBOutlet weak var DKcontentLabel: UILabel!
    
    var knowledge: Knowledge?
    
    var isMarked: Bool = false
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true)
        
        
        
    }
    
    override func loadView() {
        super.loadView()
        print("Load Detail")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        DKtitleLabel.text = knowledge?.title
        
        DKcontentLabel.text = knowledge?.content
        
//        self.navigationController?.isNavigationBarHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }

}
