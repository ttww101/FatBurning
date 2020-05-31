//
//  PracticeVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/8.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit

class PracticeVC: UIViewController, UICollectionViewDelegate, UITableViewDelegate {

    @IBOutlet weak var PVprogressCollectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var PVpreviousBtn: UIButton!
    
    @IBOutlet weak var PVnextBtn: UIButton!
    
    @IBOutlet weak var PVworkoutImageView: UIImageView!
    
    var PVworkoutArray: [WorkoutSet]?
    
    var workoutIndex: Int = 0 {
        
        didSet {
            
            tableView.reloadData()
            
            PVprogressCollectionView.reloadData()
            
            setupBtn()
            
            setupGifImage()
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.lw_registerCellWithNib(
            identifier: String(describing: PracticeActivityInfoTableViewCell.self),
            bundle: nil)
        
        tableView.lw_registerCellWithNib(
            identifier: String(describing: SecondActivityInfoTableViewCell.self),
            bundle: nil)
        
        setupGifImage()
        
        setupBtn()

    }
    
    private func setupGifImage() {
        
        guard let workoutArray = PVworkoutArray else { return }
        let currentWorkout = workoutArray[workoutIndex]
        var images: [UIImage?] = []
        for i in 0..<currentWorkout.images.count {
            images.append(UIImage(named: currentWorkout.images[i]))
        }
        PVworkoutImageView.animationImages = images as? [UIImage]
        
        PVworkoutImageView.animationDuration = currentWorkout.perDuration
        PVworkoutImageView.startAnimating()
        
    }
    
    private func setupBtn() {
        
        if workoutIndex > 0 {
            PVpreviousBtn.backgroundColor = .Orange
        } else {
            PVpreviousBtn.backgroundColor = .B3
        }
        
        var finalnum = 3
        if let workoutArray = PVworkoutArray {
            finalnum = workoutArray.count - 1
        }
        
        if workoutIndex < finalnum {
            PVnextBtn.backgroundColor = .Orange
        } else {
            PVnextBtn.backgroundColor = .B3
        }
        
    }
    
    @IBAction func previousBtnPressed(_ sender: UIButton) {
        
        PVnextBtn.isEnabled = true
        
        if workoutIndex > 0 {
            workoutIndex -= 1
            PVpreviousBtn.isEnabled = true
        } else {
            PVpreviousBtn.isEnabled = false
            
        }
        
    }
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        
        PVpreviousBtn.isEnabled = true
        
        var finalnum = 3
        if let workoutArray = PVworkoutArray {
            finalnum = workoutArray.count - 1
        }
        if workoutIndex < finalnum {
            workoutIndex += 1
            PVnextBtn.isEnabled = true
        } else {
            PVnextBtn.isEnabled = false
        }
        
    }
    
    @IBAction func dismissBtnPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

}

extension PracticeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: PracticeActivityInfoTableViewCell.self),
            for: indexPath
        )
        
        let cellReuse = tableView.dequeueReusableCell(
            withIdentifier: String(describing: SecondActivityInfoTableViewCell.self),
            for: indexPath
        )
        
        guard let firstCell = cell as? PracticeActivityInfoTableViewCell else { return cell }
        
        guard let secondCell = cellReuse as? SecondActivityInfoTableViewCell else { return cell }
        
        guard let currentWorkout = PVworkoutArray?[workoutIndex] else { return cell }
        
        if indexPath.row == 0 {
            
            firstCell.layoutView(title: currentWorkout.title, description: currentWorkout.description)
            
            return firstCell
            
        } else {
            
            guard let annotation = currentWorkout.annotation else { return UITableViewCell() }
            
            secondCell.layoutView(annotation: annotation[0])
            
            return secondCell
            
        }
    }
    
}

extension PracticeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let workoutArray = PVworkoutArray else { return 0 }
        
        return workoutArray.count
    }
    
    // swiftlint:disable identifier_name
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = PVprogressCollectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCell", for: indexPath)
        
        if let workoutArray = PVworkoutArray {
            var background = [UIColor?]()
            
            for _ in 0..<workoutArray.count {
                background.append(.B5)
            }
            
            for i in 0...workoutIndex {
                background[i] = .Orange
            }
            
            cell.backgroundColor = background[indexPath.item]
        }
        
        return cell
        
    }
    
}

extension PracticeVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard let workoutCount = workoutSet?.count else { return CGSize() }
//        let workoutCountCGFlaot = CGFloat(workoutCount)
//        let cellWidth = (self.view.frame.width - (workoutCountCGFlaot - 1) * 2) / workoutCountCGFlaot
        var cellWidth = (self.view.frame.width - 6) / 4
        
        if let workoutArray = PVworkoutArray {
            cellWidth = (self.view.frame.width - 6) / CGFloat(workoutArray.count)
        }
        
        return CGSize(width: cellWidth, height: 5)
    }

}
