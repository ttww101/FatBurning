//
//  StretchWorkoutVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/24.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit
import AVFoundation

// swiftlint:disable identifier_name
class StretchWorkoutVC: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var SWworkoutTitleLabel: UILabel!
    
    @IBOutlet weak var SWinfoLabel: UILabel!
    
    @IBOutlet weak var SWcountDownLabel: UILabel!
    
    @IBOutlet weak var SWrepeatCollectionView: UICollectionView!
    
    @IBOutlet weak var SWbarProgressView: UIProgressView!
    
    @IBOutlet weak var SWworkoutImageView: UIImageView!
    
    @IBOutlet weak var SWsoundBtn: UIButton!
    
    var navTitle: String?
    
    var barTimer: Timer?
    
    var repeatTimer: Timer?
    
    var counter = 1
    
    var SWworkoutArray: [WorkoutSet]?
    
    var SWworkoutIndex = 0
    
    var SWrepeatCountingText = [String]()
    
    var currentRepeat = 1
    
    var SWworkoutMinutes: Float? = 5
    
    var SWcurrentTime: Float = 0.0 {
        
        didSet {
            print(SWcurrentTime)
        }
        
    }
    
    var soundIsOn: Bool = true // offIcon -> selected
    
    @IBAction func toggleSonudBtnPressed(_ sender: UIButton) {
        
        soundIsOn = !soundIsOn
        
        if soundIsOn == true {
            
            SWdoneAudioPlayer.volume = 1
            
            SWkeepAudioPlayer.volume = 1
            
            SWsoundBtn.isSelected = true // onIcon -> default
            
        } else {
            
            SWdoneAudioPlayer.volume = 0
            
            SWkeepAudioPlayer.volume = 0
            
            SWsoundBtn.isSelected = false
            
        }
        
    }
    
    var SWkeepAudioPlayer = AVAudioPlayer()
    
    var SWdoneAudioPlayer = AVAudioPlayer()
    
    var countSoundFileName = 1
    
    var doneCounting = 1
    
    private func setAndPlayCountSound(soundFile: Int) {
        
        let sound = Bundle.main.path(forResource: "Keep", ofType: "mp3")
        
        do {
            try SWkeepAudioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
        SWkeepAudioPlayer.play()
        
        if soundIsOn == true {
            
            SWkeepAudioPlayer.volume = 1
            
        } else {
            
            SWkeepAudioPlayer.volume = 0
        }
    }
    
    private func setupDoneAudioPlayer() {
        
        let sound = Bundle.main.path(forResource: "DonePerCount", ofType: "mp3")
        
        do {
            try SWdoneAudioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        navigationItem.title = navTitle
        
        setupDoneAudioPlayer()
        
        setAndPlayCountSound(soundFile: self.countSoundFileName)
        
        countSoundFileName += 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        changeTitleAndRepeatText()
        
        updateBarProgress()
        
        guard let workoutArray = SWworkoutArray else { return }
        let currentWorkout = workoutArray[SWworkoutIndex]
        SWworkoutImageView.image = UIImage(named: currentWorkout.images[1])
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        repeatTimer?.invalidate()
        barTimer?.invalidate()
        
        SWrepeatCountingText = [String]()
        
        SWdoneAudioPlayer.pause()
        SWkeepAudioPlayer.pause()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let workoutMinutes = SWworkoutMinutes else { return }
        let maxTime = workoutMinutes * 60.0
        if let destination = segue.destination as? StretchCountdownVC {
            destination.currentTime = self.SWcurrentTime
//            destination.maxTime = maxTime
        }
        
        if let pauseVC = segue.destination as? PauseVC {
            pauseVC.currentTime = self.SWcurrentTime
            pauseVC.maxTime = maxTime
            pauseVC.PVworkoutArray = SWworkoutArray
            pauseVC.PVworkoutIndex = SWworkoutIndex
        }
        
        if let finishVC = segue.destination as? FinishWorkoutVC {
            finishVC.currentTime = self.SWcurrentTime
        }
        
        if let prepareVC = segue.destination as? StretchPrepareVC {
            prepareVC.currentTime = SWcurrentTime
            currentRepeat += 1
            prepareVC.currentRepeat = currentRepeat
            prepareVC.SPrepeatCollectionView.reloadData()
            
        }
    }
    
    private func changeTitleAndRepeatText() {
        
        guard let workoutArray = SWworkoutArray else { return }
        
        let currentWorkout = workoutArray[SWworkoutIndex]
        
        SWworkoutTitleLabel.text = currentWorkout.title
        SWinfoLabel.text = currentWorkout.hint
        
        counter = workoutArray[SWworkoutIndex].count
        SWcountDownLabel.text = "00:\(String(format: "%02d", self.counter))"
        
        changeRepeatCounts(totalCount: currentWorkout.count, timeInterval: currentWorkout.perDuration)
        
        SWrepeatCollectionView.reloadData()
        
    }
    
    private func changeRepeatCounts(totalCount: Int, timeInterval: TimeInterval) {
        
        repeatTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            
            if self.counter > 0 {
                self.counter -= 1
                self.SWcountDownLabel.text = "00:\(String(format: "%02d", self.counter))"
//                progressView.value = CGFloat(30 - counter)
                
            } else {
                
                // 進入下一個 rep
                self.repeatTimer?.invalidate()
                self.barTimer?.invalidate()
                self.moveToNextVC()
                
                guard let workoutArray = self.SWworkoutArray else { return }
                
                // 判斷是否完成所有的rep
                if self.currentRepeat < workoutArray[self.SWworkoutIndex].workoutSetRepeat {
//                    self.currentRepeat += 1
                    
                    self.counter = 1
                    self.changeTitleAndRepeatText()
                    
                    self.updateBarProgress()
                    
                    self.doneCounting = 1
                    
                    self.countSoundFileName = 1
                    self.setAndPlayCountSound(soundFile: self.countSoundFileName)
                    self.countSoundFileName += 1
                    
                } else {
                    // 完成一個動作的所有rep，換下一個動作
//                    self.workoutIndex += 1
                    self.currentRepeat = 1
                
                }
                
            }
            
        })
        
    }
    
    private func updateBarProgress() {
        
        guard let workoutMinutes = SWworkoutMinutes else { return }
        let maxTime = workoutMinutes * 60.0
        
        SWcurrentTime += 1.0
        SWbarProgressView.progress = self.SWcurrentTime/maxTime
        
        barTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
            if self.SWcurrentTime < maxTime {
                self.SWcurrentTime += 1.0
                self.SWbarProgressView.progress = self.SWcurrentTime/maxTime
            } else {
                return
            }
        })
    }
    
    private func moveToNextVC() {
        
        guard let workoutArray = SWworkoutArray else { return }
        
        if currentRepeat == workoutArray[SWworkoutIndex].workoutSetRepeat && SWworkoutIndex == (workoutArray.count - 1) {
            performSegue(withIdentifier: "finishStretch", sender: self)
        } else if currentRepeat == workoutArray[SWworkoutIndex].workoutSetRepeat {
            performSegue(withIdentifier: "unwindToCountdown", sender: self)
            self.loadViewIfNeeded()
        } else {
            performSegue(withIdentifier: "unwindToPrepare", sender: self)
        }
        
    }
    
}

extension StretchWorkoutVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let workoutArray = SWworkoutArray else { return 0 }
        
        return workoutArray[SWworkoutIndex].workoutSetRepeat
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cell = SWrepeatCollectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: RepeatCollectionViewCell.self),
            for: indexPath
        )
        
        guard let repeatCell = cell as? RepeatCollectionViewCell else { return cell }
        
        var bgColorArray = [UIColor?]()
        var textColorArray = [UIColor?]()
        guard let workoutArray = SWworkoutArray else { return cell }
        
        for _ in 0..<workoutArray[SWworkoutIndex].workoutSetRepeat {
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

extension StretchWorkoutVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        guard let workoutArray = SWworkoutArray else { return CGSize() }
        let collectionViewWidth = SWrepeatCollectionView.bounds.width
        let cellSpace = Int(collectionViewWidth) / workoutArray[SWworkoutIndex].workoutSetRepeat
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
