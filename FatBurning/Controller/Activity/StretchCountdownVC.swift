//
//  StretchCountdownVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/5/5.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit
import AVFoundation

class StretchCountdownVC: UIViewController {
    
    @IBOutlet weak var SCcountDownLabel: UILabel!
    
    @IBOutlet weak var SCworkoutTItle: UILabel!
    
    @IBOutlet weak var SCworkoutImage: UIImageView!
    
    @IBOutlet weak var SCbarProgressView: UIProgressView!
    
    var timer = Timer()
    var counter = 5
    var SCworkoutMinutes: Float?
    var SCworkoutArray: [WorkoutSet]?
    var SCworkoutIndex = 0
    var navTitle: String?
    var currentTime: Float = 0.0
//    var maxTime: Float = 0.0
    
    var SCaudioPlayer = AVAudioPlayer()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.invalidate()
        
        counter = 5
        
        SCworkoutIndex += 1
        
    }
    
    @IBAction func unwindtoCountdown(segue: UIStoryboardSegue) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
        
        let maxTime = SCworkoutMinutes! * 60.0
        
        SCbarProgressView.progress = currentTime / maxTime
        
        guard let workoutArray = SCworkoutArray else { return }
        
        SCworkoutImage.image = UIImage(named: workoutArray[SCworkoutIndex].thumbnail)
        
        SCworkoutTItle.text = workoutArray[SCworkoutIndex].title
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SCcountDownLabel.text = "\(counter)"
        
        setupAudioPlayer()
        
        SCaudioPlayer.play()
        
        navigationItem.title = navTitle
        
    }
    
    @objc func updateTimer() {
        if counter > 0 {
            counter -= 1
            SCcountDownLabel.text = String(format: "%d", counter)
            
            SCaudioPlayer.play()
            
        } else {
            performSegue(withIdentifier: "prepareStretch", sender: self)
            timer.invalidate()
        }
        
    }
    
    private func setupAudioPlayer() {
        
        let sound = Bundle.main.path(forResource: "Countdown", ofType: "mp3")
        
        do {
            try SCaudioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desVC = segue.destination as? StretchPrepareVC,
            let workoutMinutes = SCworkoutMinutes {
            desVC.SPworkoutMinutes = workoutMinutes
            desVC.currentTime = currentTime
            desVC.SPworkoutArray = SCworkoutArray
            desVC.navTitle = navTitle
            desVC.SPworkoutIndex = SCworkoutIndex
        }
        
        if let pauseVC = segue.destination as? PauseVC {
            pauseVC.currentTime = self.currentTime
            pauseVC.maxTime = SCworkoutMinutes! * 60
            pauseVC.PVworkoutArray = SCworkoutArray
            pauseVC.PVworkoutIndex = SCworkoutIndex
        }

    }
}
