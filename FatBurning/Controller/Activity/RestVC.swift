//
//  RestVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/12.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class RestVC: UIViewController {
    
    @IBOutlet weak var RVcountDownLabel: UILabel!
    
    @IBOutlet weak var RVprogressView: MBCircularProgressBarView!
    
    @IBOutlet weak var RVbarProgressView: UIProgressView!
    
    @IBOutlet weak var RVnextWorkoutTItle: UILabel!
    
    @IBOutlet weak var RVnextWorkoutImage: UIImageView!

    var navTitle: String?
    
    var timer = Timer()
    
    var counter = 30
    
    var currentTime: Float = 0.0
    
    var maxTime: Float = 0.0
    
    var RVworkoutArray: [WorkoutSet]?
    
    var RVworkoutIndex = 0
    
    @IBAction func skipRestBtnPressed(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: false)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        let nextIndex = RVworkoutIndex + 1
        
        guard let nextWorkout = RVworkoutArray?[nextIndex] else { return }
        
        RVnextWorkoutTItle.text = nextWorkout.title
        
        RVnextWorkoutImage.image = UIImage(named: nextWorkout.thumbnail)
        
        RVcountDownLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true)
        
        RVbarProgressView.progress = currentTime / maxTime
        
    }
    
    @objc func updateTimer() {
        
        if counter > 0 {
            counter -= 1
            RVcountDownLabel.text = String(format: "%d", counter)
            RVprogressView.value = CGFloat(30 - counter)
            
        } else {
            
            self.navigationController?.popViewController(animated: false)
            timer.invalidate()
            
        }
    }

}
