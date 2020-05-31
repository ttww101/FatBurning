//
//  ActivityVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/2.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit

class ActivityVC: LWBaseVC, UICollectionViewDelegate, UIScrollViewDelegate {
    
    deinit {
        print("ActivityVC deinit")
    }

    @IBOutlet weak var AcVscrollView: UIScrollView!
    @IBOutlet weak var AcVindicatorView: UIView!
    @IBOutlet weak var AcVindicatorLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var AcVfirstCollectionView: UICollectionView!
    @IBOutlet weak var AcVsecondCollectionView: UICollectionView!
    @IBOutlet weak var AcVinfoBtn: UIButton!
    @IBOutlet weak var AcVinfoBottonConstraint: NSLayoutConstraint!
    @IBOutlet weak var AcVinfoView: UIView!
    
    @IBOutlet var AcVorderBtns: [UIButton]!

    var collectionViews: [UICollectionView] {

        return [AcVfirstCollectionView, AcVsecondCollectionView]

    }

    let manager = ActivityManager()
    
    let workoutManager = WorkoutManager()
    
    var trainElementsArray: [WorkoutElement]? {
        didSet {
            AcVfirstCollectionView.reloadData()
        }
    }
    
    var stretchElementsArray: [WorkoutElement]? {
        didSet {
            AcVsecondCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutManager.getWorkout(activity: ActivityItems.train) { [weak self] (train, _ ) in
            self?.trainElementsArray = train
        }
        
        workoutManager.getWorkout(activity: ActivityItems.stretch) { [weak self] (stretch, _ ) in
            self?.stretchElementsArray = stretch
        }

        AcVscrollView.delegate = self
        
        AcVfirstCollectionView.lw_registerCellWithNib(
            identifier: String(describing: ActivityHeaderCollectionViewCell.self),
            bundle: nil)
        
        AcVsecondCollectionView.lw_registerCellWithNib(
            identifier: String(describing: ActivityHeaderCollectionViewCell.self),
            bundle: nil)
        
        AcVfirstCollectionView.lw_registerCellWithNib(
            identifier: String(describing: ActivityCollectionViewCell.self),
            bundle: nil)
        
        AcVsecondCollectionView.lw_registerCellWithNib(
            identifier: String(describing: ActivityCollectionViewCell.self),
            bundle: nil)

        self.navigationController?.isNavigationBarHidden = true

    }

    @IBAction func changePagePressed(_ sender: UIButton) {

        for btn in AcVorderBtns {

            btn.isSelected = false

        }

        sender.isSelected = true

        moveIndicatorView(toPage: sender.tag)
    }

    private func moveIndicatorView(toPage: Int) {

        let screenWidth  = UIScreen.main.bounds.width

        AcVindicatorLeadingConstraint.constant = CGFloat(toPage) * screenWidth / 2

        UIView.animate(withDuration: 0.3) {

            self.AcVscrollView.contentOffset.x = CGFloat(toPage) * screenWidth

            self.view.layoutIfNeeded()

        }

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let screenWidth  = UIScreen.main.bounds.width

        AcVindicatorLeadingConstraint.constant = scrollView.contentOffset.x / 2

        let temp = Double(scrollView.contentOffset.x / screenWidth)

        let number = lround(temp)

        for btn in AcVorderBtns {

            btn.isSelected = false

        }
        
        if number < 2 && number >= 0 {
            
            AcVorderBtns[number].isSelected = true
            
            UIView.animate(withDuration: 0.1) {
                
                self.view.layoutIfNeeded()
                
            }
            
        }

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

//        if indexPath.section == 1 {

            if collectionView == AcVfirstCollectionView {

                performSegue(withIdentifier: "setupTrain", sender: nil)

            } else {

                performSegue(withIdentifier: "setupStretch", sender: nil)

            }

//        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let trainDestination = segue.destination as? TrainSetupVC {

            var indexPath = self.AcVfirstCollectionView.indexPathsForSelectedItems?.first
            
            guard let trainElements = trainElementsArray else { return }
            
            let passItem = trainElements[indexPath!.row]
            
            trainDestination.TSid = passItem.id
            
        }

        if let stretchDestination = segue.destination as? StretchSetupVC {

            var indexPath = self.AcVsecondCollectionView.indexPathsForSelectedItems?.first
            
            guard let stretchElements = stretchElementsArray else { return }
            
            let passItem = stretchElements[indexPath!.row]
            
            stretchDestination.SSid = passItem.id

        }

    }

    var open = false
    @IBAction func InfoClick(_ sender: UIButton) {
        open = !open
        UIView.animate(withDuration: 0.2) {
            if self.open {
                sender.setImage(UIImage(named: "downbtn"), for: .normal)
                self.AcVinfoBottonConstraint.constant += 130
            } else {
                sender.setImage(UIImage(named: "upbtn"), for: .normal)
                self.AcVinfoBottonConstraint.constant -= 130
            }
            self.view.layoutIfNeeded()
        }
//        UIView.animate(withDuration: 0.3, animations: {
//            if self.open {
//                sender.setImage(UIImage(named: "downbtn"), for: .normal)
//                self.AcVinfoView.center.y += 130
//            } else {
//                sender.setImage(UIImage(named: "upbtn"), for: .normal)
//                self.AcVinfoView.center.y -= 130
//            }
//        }) { (completion) in
//            if completion {
//                if self.open {
//                    self.AcVinfoBottonConstraint.constant = 0
//                } else {
//                    self.AcVinfoBottonConstraint.constant = -130
//                }
//            }
//        }
    }
}

extension ActivityVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if section == 0 {
//
//            return 1
//
//        } else {
        
            switch collectionView {
                
            case AcVfirstCollectionView: return trainElementsArray?.count ?? 0
                
            case AcVsecondCollectionView: return stretchElementsArray?.count ?? 0
                
            default: return 0
                
            }
            
//        }
        
    }
    
    func collectionView(
            _ collectionView: UICollectionView,
            cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        
//        if indexPath.section == 0 {
//
//            let cell = collectionView.dequeueReusableCell(
//                withReuseIdentifier: "ActivityHeaderCollectionViewCell",
//                for: indexPath
//            )
//
//            guard let headerCell = cell as? ActivityHeaderCollectionViewCell else { return cell }
//
//            let trainGroup = manager.trainGroup
//            let stretchGroup = manager.stretchGroup
//            if collectionView == AcVfirstCollectionView {
//
//                headerCell.layoutCell(
//                    firstLine: trainGroup.firstLineTitle,
//                    secondLine: trainGroup.secondLineTitle,
//                    caption: trainGroup.caption,
//                    crossImage: #imageLiteral(resourceName: "Image_OrangeCross.png"),
//                    corner: .bottomLeft
//                )
//
//            } else {
//
//                headerCell.layoutCell(
//                    firstLine: stretchGroup.firstLineTitle,
//                    secondLine: stretchGroup.secondLineTitle,
//                    caption: stretchGroup.caption,
//                    crossImage: #imageLiteral(resourceName: "Image_GreenCross"),
//                    corner: .bottomRight
//                )
//
//            }
//
//            return headerCell
//
//        } else {
        
            if collectionView == AcVfirstCollectionView {
                
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "ActivityCollectionViewCell",
                    for: indexPath
                )
                
                guard let trainCell = cell as? ActivityCollectionViewCell else { return cell }
                
                guard let trainElements = trainElementsArray else { return cell }
                
                let trainItems = trainElements[indexPath.row]
                
                trainCell.layoutView(title: trainItems.title, image: trainItems.icon)
                
                return trainCell
                
            } else if collectionView == AcVsecondCollectionView {
                
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "ActivityCollectionViewCell",
                    for: indexPath
                )
                
                guard let stretchCell = cell as? ActivityCollectionViewCell else { return cell }
                
                guard let stretchElements = stretchElementsArray else { return cell }
                
                let stretchItems = stretchElements[indexPath.row]
                
                stretchCell.layoutView(title: stretchItems.title, image: stretchItems.icon)
                
                return stretchCell
                
            }
            
            return UICollectionViewCell()
            
//        }
        
    }
    
}

extension ActivityVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

//        if indexPath.section == 0 {
//
//            return CGSize(width: view.frame.width, height: 166)
//
//        } else {

            switch collectionView {

            case AcVfirstCollectionView: return CGSize(width: (AcVfirstCollectionView.bounds.width - 20) / 2.0, height: 152.0)

            default: return CGSize(width: (AcVsecondCollectionView.bounds.width - 20) / 2.0, height: 152.0)

            }

//        }

    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
        ) -> CGFloat {
        return 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
        ) -> CGFloat {
        return 8
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
        ) -> UIEdgeInsets {

//        if section == 0 {
//            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        }

    }

}
