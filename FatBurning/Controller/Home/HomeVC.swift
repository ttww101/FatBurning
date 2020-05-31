//
//  HomeVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/3.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import MKProgress

class HomeVC: LWBaseVC, UICollectionViewDelegate, HomeManagerDelegate {

    @IBOutlet weak var HVsuggestTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var HVtimeLabel: UILabel!
    
    @IBOutlet weak var HVstatusLabel: UILabel!
    
    @IBOutlet weak var HVshareBtn: UIButton!
    
    @IBOutlet weak var HVstatusRemainTimeLabel: UILabel!
    
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var HVtrainProgressView: MBCircularProgressBarView!

    @IBOutlet weak var HVstretchProgressView: MBCircularProgressBarView! // 後面、加總
    
    @IBOutlet weak var HVtodayWorkoutTimeLabel: UILabel!

    @IBOutlet weak var HVworkoutCollectionView: UICollectionView!

    @IBOutlet weak var HVweekProgressCollectionView: UICollectionView!
    
    @IBOutlet weak var HVstillRemainLabel: UILabel!
    
    @IBOutlet weak var HVremainingTimeLabel: UILabel!
    
    @IBOutlet weak var HVstatusImg: UIImageView!
    
    var HVtodayDate = ""
    
    lazy var homeManager: HomeManager = {
        
        let model = HomeManager()
        
        model.delegate = self
        
        return model
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HVshareBtn.isEnabled = false

        ProgressHud.showProgressHud()
        
        if UIScreen.main.nativeBounds.height == 1136 {
            
            HVstatusRemainTimeLabel.isHidden = true
            
        }
        
    }
    
    override func getData() {
        
        homeManager.activate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        homeManager.reset()
    }
    
    // MARK: - HomeManagerDelegate
    
    func didGet(date: String, homeObject: HomeObject, description: String) {
        
        HVtimeLabel.text = date
        
        HVstatusLabel.text = homeObject.title
        
        HVstatusImg.setAnimation(imgs: homeObject.imgs.toImgArray(), duration: 1.5, repeatC: 0)
        
        HVstatusRemainTimeLabel.text = description
        
        background.image = UIImage(named: homeObject.background)
        
        HVworkoutCollectionView.reloadData()
        
    }
    
    func didGet(todayTrainTime: Int, todayStretchTime: Int) {
        
        let totalWorkoutTime = todayTrainTime + todayStretchTime

        HVtodayWorkoutTimeLabel.text = "\(totalWorkoutTime)"

        UIView.animate(withDuration: 0.5) {
            if totalWorkoutTime >= 15 {
                self.HVstretchProgressView.value = 15
                self.HVtrainProgressView.value = CGFloat(integerLiteral: todayTrainTime * 15 / totalWorkoutTime)
            } else {
                self.HVstretchProgressView.value = CGFloat(totalWorkoutTime)
                self.HVtrainProgressView.value = CGFloat(integerLiteral: todayTrainTime)
            }
        }

        if totalWorkoutTime >= 15 {
            HVstillRemainLabel.text = "太棒了"
            HVremainingTimeLabel.text = "達成目標"
        } else {
            HVstillRemainLabel.text = "還差"
            HVremainingTimeLabel.text = "\(15 - totalWorkoutTime)分鐘"
        }

        HVweekProgressCollectionView.reloadData()
        
        self.HVshareBtn.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let trainWorkoutTime = homeManager.trainWorkoutTime

        let stretchWorkoutTime = homeManager.stretchWorkoutTime

        let totalWorkoutTime = stretchWorkoutTime + trainWorkoutTime

        if let desVC = segue.destination as? ShareVC {
            
            desVC.SVdailyValue = homeManager.homeProvider.dailyValue
            
            desVC.loadViewIfNeeded()
            
            desVC.SVtodayTotalTimeLabel.text = "\(totalWorkoutTime)"
            
            desVC.SVtrainTimeLabel.text = "\(trainWorkoutTime)分鐘"
            
            desVC.SVstretchTimeLabel.text = "\(stretchWorkoutTime)分鐘"
            
            desVC.SVtodayDateLabel.text = HVtodayDate

            if totalWorkoutTime >= 15 {
                
                    desVC.SVstretchProgressView.value = 15
                
                    desVC.SVtrainProgressView.value = CGFloat(integerLiteral: trainWorkoutTime * 15 / totalWorkoutTime)
                
            } else {
                
                    desVC.SVstretchProgressView.value = CGFloat(totalWorkoutTime)
                
                    desVC.SVtrainProgressView.value = CGFloat(integerLiteral: trainWorkoutTime)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if collectionView == HVworkoutCollectionView {

            guard let homeObject = homeManager.homeObject else { return }

            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Activity", bundle: nil)

            if homeObject.status == "resting" {

                let desVC = mainStoryboard.instantiateViewController(withIdentifier: "TrainSetupVC")
                guard let trainVC = desVC as? TrainSetupVC else { return }
                trainVC.TSid = homeObject.workoutSet[indexPath.item].id
                self.present(trainVC, animated: true)

            } else {

                let desVC = mainStoryboard.instantiateViewController(withIdentifier: "StretchSetupVC")
                guard let stretchVC = desVC as? StretchSetupVC else { return }
                stretchVC.SSid = homeObject.workoutSet[indexPath.item].id
                self.present(stretchVC, animated: true)

            }
        }
    }
}

extension HomeVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == HVworkoutCollectionView {

            guard let workoutSet = homeManager.homeObject?.workoutSet else { return 0 }

            return workoutSet.count

        } else if collectionView == HVweekProgressCollectionView {

            return 7

        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == HVworkoutCollectionView {

            let cell = HVworkoutCollectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: HomeCollectionViewCell.self),
                for: indexPath)

            guard let homeCell = cell as? HomeCollectionViewCell else { return cell }

            guard let workoutElement = homeManager.homeObject?.workoutSet[indexPath.row] else { return cell }

            homeCell.layoutCell(image: workoutElement.buttonImage)

            return homeCell

        } else if collectionView == HVweekProgressCollectionView {

            let days = ["ㄧ", "二", "三", "四", "五", "六", "日"]

            let cell = HVweekProgressCollectionView.dequeueReusableCell(
                withReuseIdentifier: "WeekProgressCollectionViewCell", for: indexPath)

            guard let progressCell = cell as? WeekProgressCollectionViewCell else { return cell }

            progressCell.dayLabel.text = days[indexPath.item]
            
            progressCell.layoutView(value: homeManager.dailyValue[indexPath.item])

            return progressCell

        }

        return UICollectionViewCell()
    }

}

extension HomeVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == HVworkoutCollectionView {

            return CGSize(width: 165, height: 119)

        } else {

            return CGSize(width: 20, height: 40)

        }

    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        if collectionView == HVweekProgressCollectionView {

            return 21

        } else {

            return 0

        }

    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        if collectionView == HVworkoutCollectionView {
            
            let height = CGFloat(119) // collectionView.visibleCells[0].frame.height
            
            let viewHeight = collectionView.frame.size.height
            
            let toBottomUp = viewHeight - height

            return UIEdgeInsets(top: 0, left: 16, bottom: toBottomUp, right: 0)

        } else {

            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        }

    }

}
