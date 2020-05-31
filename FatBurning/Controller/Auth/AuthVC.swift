//
//  AuthVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/22.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit
////import Firebase

class AuthVC: STBaseVC, UIScrollViewDelegate {
    
    @IBOutlet weak var AVpageControl: UIPageControl!
    
    @IBOutlet weak var AVscrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVscrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        
        if pageNumber < 4 && pageNumber >= 0 {
         
            AVpageControl.currentPage = Int(pageNumber)
        }
    }
}
