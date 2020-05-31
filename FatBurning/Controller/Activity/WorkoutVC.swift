//
//  WorkoutVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/11.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit
import AVFoundation

// swiftlint:disable identifier_name
class WorkoutVC: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var WVworkoutTitleLabel: UILabel!
    
    @IBOutlet weak var WVinfoLabel: UILabel!
    
    @IBOutlet weak var WVrepeatLabel: UILabel!
    
    @IBOutlet weak var WVrepeatCollectionView: UICollectionView!
    
    @IBOutlet weak var WVbarProgressView: UIProgressView!
    
    @IBOutlet weak var WVworkoutImageView: UIImageView!
    
    @IBOutlet weak var WVsoundBtn: UIButton!
    
    var navTitle: String?
    
    var barTimer: Timer?
    
    var repeatTimer: Timer?
    
    var counter = 1
    
    var WVworkoutArray: [WorkoutSet]?
    
    var WVworkoutIndex = 0
    
    var WVrepeatCountingText = [String]()
    
    var WVcurrentRepeat = 1
    
    var WVworkoutMinutes: Float?
    
    var WVcurrentTime: Float = 0.0
    
    var soundIsOn: Bool = true // offIcon -> selected
    
    var WVtimeBasedWorkoutArray = [WorkoutSet]()
    
    var timeBase: Int {
        if WVworkoutMinutes == 5 {
            return 1
        } else if WVworkoutMinutes == 10 {
            return 2
        } else {
            return 3
        }
        
    } // 5 (1), 10 (2), 15 (3) min
    
    @IBAction func toggleSonudBtnPressed(_ sender: UIButton) {
        
        soundIsOn = !soundIsOn
        
        if soundIsOn == true {
            
            WVdoneAudioPlayer.volume = 1
            
            WVcountAudioPlayer.volume = 1
            
            WVsoundBtn.isSelected = true // onIcon -> default
            
        } else {
            
            WVdoneAudioPlayer.volume = 0
            
            WVcountAudioPlayer.volume = 0
            
            WVsoundBtn.isSelected = false
            
        }
        
    }
    
    var WVcountAudioPlayer = AVAudioPlayer()
    
    var WVdoneAudioPlayer = AVAudioPlayer()
    
    var countSoundFileName = 1
    
    var doneCounting = 1
    
    private func setAndPlayCountSound(soundFile: Int) {
        
        let sound = Bundle.main.path(forResource: String(soundFile), ofType: "mp3")
        
        do {
            try WVcountAudioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
        WVcountAudioPlayer.play()
        
        if soundIsOn == true {
            
            WVcountAudioPlayer.volume = 1
            
        } else {
            
            WVcountAudioPlayer.volume = 0
        }
    }
    
    private func setupDoneAudioPlayer() {
        
        let sound = Bundle.main.path(forResource: "DonePerCount", ofType: "mp3")
        
        do {
            try WVdoneAudioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
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
        
        guard let workoutArray = WVworkoutArray else { return }
        
        for _ in 1...timeBase {
            WVtimeBasedWorkoutArray.append(contentsOf: workoutArray)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        changeTitleAndRepeatText()
        
        updateBarProgress()
        
        setupGif()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        repeatTimer?.invalidate()
        barTimer?.invalidate()
        
        WVrepeatCountingText = [String]()
        
        WVdoneAudioPlayer.pause()
        WVcountAudioPlayer.pause()
        
        counter = 0
        countSoundFileName = 1
    }
    
    private func setupGif() {
        
        guard WVworkoutArray != nil else { return }
        let currentWorkout = WVtimeBasedWorkoutArray[WVworkoutIndex]
        
        WVworkoutImageView.animationImages = currentWorkout.images.toImgArray()
        
        WVworkoutImageView.animationDuration = currentWorkout.perDuration
        WVworkoutImageView.startAnimating()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let workoutMinutes = WVworkoutMinutes else { return }
        let maxTime = workoutMinutes * 60.0
        if let destination = segue.destination as? RestVC {
            destination.currentTime = self.WVcurrentTime
            destination.maxTime = maxTime
            destination.navTitle = navTitle
            destination.RVworkoutArray = WVtimeBasedWorkoutArray
            destination.RVworkoutIndex = WVworkoutIndex
        }
        
        if let pauseVC = segue.destination as? PauseVC {
            pauseVC.currentTime = self.WVcurrentTime
            pauseVC.maxTime = maxTime
            pauseVC.PVworkoutArray = WVtimeBasedWorkoutArray
            pauseVC.PVworkoutIndex = WVworkoutIndex
        }
        
        if let finishVC = segue.destination as? FinishWorkoutVC {
            finishVC.currentTime = self.WVcurrentTime
        }
        
    }
    
    private func changeTitleAndRepeatText() {
        
        guard WVworkoutArray != nil else { return }
        
        let currentWorkout = WVtimeBasedWorkoutArray[WVworkoutIndex]
        
        WVworkoutTitleLabel.text = currentWorkout.title
        WVinfoLabel.text = currentWorkout.hint
        
//        counter = 1
        WVrepeatLabel.text = "\(self.counter)/\(currentWorkout.count)次"
        
        changeRepeatCounts(totalCount: currentWorkout.count, timeInterval: currentWorkout.perDuration)
        
        WVrepeatCollectionView.reloadData()
        
    }
    
    private func changeRepeatCounts(totalCount: Int, timeInterval: TimeInterval) {
        
        for i in 1...totalCount {
            let repeatCount = "\(i)/\(totalCount)次"
            WVrepeatCountingText.append(repeatCount)
        }
        
        guard self.WVworkoutArray != nil else { return }
        
        var beat = 0
        
        repeatTimer = Timer.scheduledTimer(withTimeInterval: timeInterval / 2, repeats: true, block: { (_) in
            
            beat += 1
            
//            print(beat)
            
            if beat % 2 == 0 {
                
                if self.counter < totalCount {
                    // 一個rep裡數數
                    self.WVrepeatLabel.text = self.WVrepeatCountingText[self.counter]
                    self.counter += 1
                    
                    self.setAndPlayCountSound(soundFile: self.countSoundFileName)
                    self.countSoundFileName += 1
                    
                } else {
                    
                    // 進入下一個 rep
                    self.repeatTimer?.invalidate()
                    self.barTimer?.invalidate()
                    self.moveToNextVC()
                    
                    // 判斷是否完成所有的rep
                    if self.WVcurrentRepeat < self.WVtimeBasedWorkoutArray[self.WVworkoutIndex].workoutSetRepeat {
                        self.WVcurrentRepeat += 1
                        
                        self.counter = 1
                        self.changeTitleAndRepeatText()
                        
                        self.updateBarProgress()
                        
                        self.doneCounting = 1
                        
                        self.countSoundFileName = 1
                        self.setAndPlayCountSound(soundFile: self.countSoundFileName)
                        self.countSoundFileName += 1
                        
                    } else {
                        // 完成一個動作的所有rep，換下一個動作
                        self.WVworkoutIndex += 1
                        self.WVcurrentRepeat = 1
                    }
                }
                
            } else if beat % 2 == 1 {
                    
                    self.WVdoneAudioPlayer.play()
                
            }
            
        })
        
    }
    
    private func updateBarProgress() {
        
        guard let workoutMinutes = WVworkoutMinutes else { return }
        let maxTime = workoutMinutes * 60.0
        
        WVcurrentTime += 1.0
        WVbarProgressView.progress = self.WVcurrentTime/maxTime
        
        barTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
            if self.WVcurrentTime < maxTime {
                self.WVcurrentTime += 1.0
                self.WVbarProgressView.progress = self.WVcurrentTime/maxTime
            } else {
                return
            }
        })
    }
    
    private func moveToNextVC() {
        
        guard WVworkoutArray != nil else { return }
        
        if WVcurrentRepeat == WVtimeBasedWorkoutArray[WVworkoutIndex].workoutSetRepeat &&
            WVworkoutIndex == (WVtimeBasedWorkoutArray.count - 1) {
            
            performSegue(withIdentifier: "finishWorkout", sender: self)
            
        } else if WVcurrentRepeat == WVtimeBasedWorkoutArray[WVworkoutIndex].workoutSetRepeat {
            
            performSegue(withIdentifier: "startRest", sender: self)
            
        } else {
            
            return
        }
        
    }
    
}

extension WorkoutVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard WVworkoutArray != nil else { return 0 }
        
        return WVtimeBasedWorkoutArray[WVworkoutIndex].workoutSetRepeat
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cell = WVrepeatCollectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: RepeatCollectionViewCell.self),
            for: indexPath
        )
        
        guard let repeatCell = cell as? RepeatCollectionViewCell else { return cell }
        
        var bgColorArray = [UIColor?]()
        var textColorArray = [UIColor?]()
        guard WVworkoutArray != nil else { return cell }
        
        for _ in 0..<WVtimeBasedWorkoutArray[WVworkoutIndex].workoutSetRepeat {
            let defaultViewColor = UIColor.B5
            bgColorArray.append(defaultViewColor)
            
            let defaultTextColor = UIColor.B1
            textColorArray.append(defaultTextColor)
        }
        
        for i in 0..<WVcurrentRepeat {
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

extension WorkoutVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        guard WVworkoutArray != nil else { return CGSize() }
        let collectionViewWidth = WVrepeatCollectionView.bounds.width
        let cellSpace = Int(collectionViewWidth) / WVtimeBasedWorkoutArray[WVworkoutIndex].workoutSetRepeat
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
