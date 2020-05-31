//
//  CountDownVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/11.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit
import AVFoundation

class CountDownVC: UIViewController {
    
    @IBOutlet weak var CDcountDownLabel: UILabel!
    
    @IBOutlet weak var CDworkoutTItle: UILabel!
    
    @IBOutlet weak var CDworkoutImage: UIImageView!
    
    var timer = Timer()
    var counter = 5
    var CDworkoutMinutes: Float?
    var CDworkoutArray: [WorkoutSet]?
    var navTitle: String?
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.invalidate()
        
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
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CDcountDownLabel.text = "\(counter)"
        
        guard let workoutArray = CDworkoutArray else { return }
        
        CDworkoutImage.image = UIImage(named: workoutArray[0].thumbnail)
        
        CDworkoutTItle.text = workoutArray[0].title
        
        setupAudioPlayer()
        
        audioPlayer.play()
        
        navigationItem.title = navTitle
        
    }
    
    @objc func updateTimer() {
        if counter > 0 {
            counter -= 1
            CDcountDownLabel.text = String(format: "%d", counter)

            audioPlayer.play()
        
        } else {
            performSegue(withIdentifier: "startWorkout", sender: self)
            timer.invalidate()
        }
        
    }
    
    private func setupAudioPlayer() {
        
        let sound = Bundle.main.path(forResource: "Countdown", ofType: "mp3")
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desVC = segue.destination as? WorkoutVC,
            let workoutMinutes = CDworkoutMinutes {
            desVC.WVworkoutMinutes = workoutMinutes
            desVC.WVworkoutArray = CDworkoutArray
            desVC.navTitle = navTitle
        }
        
        if let pauseVC = segue.destination as? PauseVC {
            pauseVC.currentTime = 0
            pauseVC.maxTime = 1
            pauseVC.PVworkoutArray = CDworkoutArray
        }
    }
}
