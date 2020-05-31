//
//  StretchPrepareVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/5/5.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit
import AVFoundation

// swiftlint:disable identifier_name
class StretchPrepareVC: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var SPworkoutTitleLabel: UILabel!
    
    @IBOutlet weak var SPinfoLabel: UILabel!
    
    @IBOutlet weak var SPcountDownLabel: UILabel!
    
    @IBOutlet weak var SPrepeatCollectionView: UICollectionView!
    
    @IBOutlet weak var SPbarProgressView: UIProgressView!
    
    @IBOutlet weak var SPworkoutImageView: UIImageView!
    
    @IBOutlet weak var SPsoundBtn: UIButton!
    
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    
    var navTitle: String?
    
    var barTimer: Timer?
    
    var repeatTimer: Timer?
    
    var counter = 1
    
    var SPworkoutArray: [WorkoutSet]?
    
    var SPworkoutIndex = 0
    
    var SPrepeatCountingText = [String]()
    
    var currentRepeat = 1
    
    var SPworkoutMinutes: Float? = 5
    
    var currentTime: Float = 0.0 {
        
        didSet {
            print(currentTime)
        }
        
    }
    
    var soundIsOn: Bool = true // offIcon -> selected
    
    var SPaudioPlayer = AVAudioPlayer()
    
    private func setupAudioPlayer() {
        
        let sound = Bundle.main.path(forResource: "Prepare", ofType: "mp3")
        
        do {
            try SPaudioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func toggleSonudBtnPressed(_ sender: UIButton) {
        
        soundIsOn = !soundIsOn
        
        if soundIsOn == true {
            
//            doneAudioPlayer.volume = 1
//
//            countAudioPlayer.volume = 1
            
            SPsoundBtn.isSelected = true // onIcon -> default
            
        } else {
            
//            doneAudioPlayer.volume = 0
//
//            countAudioPlayer.volume = 0
            
            SPsoundBtn.isSelected = false
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navTitle
        
        self.navigationItem.hidesBackButton = true
        
        setupAudioPlayer()
    }
    
    @IBAction func unwindtoPrepare(segue: UIStoryboardSegue) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewHeightConstraint.constant = 240
        
        guard let workoutArray = SPworkoutArray else { return }
        let currentWorkout = workoutArray[SPworkoutIndex]
        SPworkoutImageView.image = UIImage(named: currentWorkout.images[0])
        
        SPworkoutTitleLabel.text = currentWorkout.title
        SPinfoLabel.text = currentWorkout.hint
        
        let maxTime = SPworkoutMinutes! * 60.0
        SPbarProgressView.progress = currentTime / maxTime
        
        counter = workoutArray[SPworkoutIndex].count
        SPcountDownLabel.text = "00:\(String(format: "%02d", self.counter))"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            
            UIView.animate(withDuration: 7.9) {
                self.viewHeightConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
            
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
            
            self.performSegue(withIdentifier: "startStretch", sender: self)
            
        })
        
        SPaudioPlayer.play()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        viewHeightConstraint.constant = 240
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desVC = segue.destination as? StretchWorkoutVC,
            let workoutMinutes = SPworkoutMinutes {
            desVC.SWworkoutMinutes = workoutMinutes
            desVC.SWworkoutArray = SPworkoutArray
            desVC.navTitle = navTitle
            desVC.SWworkoutIndex = SPworkoutIndex
            desVC.SWcurrentTime = currentTime
            desVC.currentRepeat = currentRepeat
        }
        
        if let pauseVC = segue.destination as? PauseVC {
            pauseVC.currentTime = self.currentTime
            pauseVC.maxTime = SPworkoutMinutes!
            pauseVC.PVworkoutArray = SPworkoutArray
            pauseVC.PVworkoutIndex = SPworkoutIndex
        }
    }

}

extension StretchPrepareVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let workoutArray = SPworkoutArray else { return 0 }
        
        return workoutArray[SPworkoutIndex].workoutSetRepeat
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cell = SPrepeatCollectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: RepeatCollectionViewCell.self),
            for: indexPath
        )
        
        guard let repeatCell = cell as? RepeatCollectionViewCell else { return cell }
        
        var bgColorArray = [UIColor?]()
        var textColorArray = [UIColor?]()
        guard let workoutArray = SPworkoutArray else { return cell }
        
        for _ in 0..<workoutArray[SPworkoutIndex].workoutSetRepeat {
            let defaultViewColor = UIColor.B5
            bgColorArray.append(defaultViewColor)
            
            let defaultTextColor = UIColor.B1
            textColorArray.append(defaultTextColor)
        }
        
        for i in 0..<currentRepeat {
            let finishedViewColor = UIColor.G2
            bgColorArray[i] = finishedViewColor
            
            let finishedTextColor = UIColor.white
            textColorArray[i] = finishedTextColor
        }
        
        repeatCell.counterLabel.text = String(indexPath.item + 1)
        repeatCell.counterLabel.textColor = textColorArray[indexPath.item]
        repeatCell.cellBackground.backgroundColor = bgColorArray[indexPath.item]
        
        return repeatCell
    }
    
}

extension StretchPrepareVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        guard let workoutArray = SPworkoutArray else { return CGSize() }
        let collectionViewWidth = SPrepeatCollectionView.bounds.width
        let cellSpace = Int(collectionViewWidth) / workoutArray[SPworkoutIndex].workoutSetRepeat
        return CGSize(width: cellSpace, height: 25)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
        ) -> CGFloat {
        return 0
    }
    
}
