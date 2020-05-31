//
//  PauseVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/11.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit

class PauseVC: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var PVworkoutImageView: UIImageView!
    
    @IBOutlet weak var PVbarProgressView: UIProgressView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentTime: Float = 0.0
    
    var maxTime: Float = 0.0
    
    var PVworkoutArray: [WorkoutSet]?
    
    var PVworkoutIndex = 0
    
    @IBAction func resumeWorkoutPressed(_ sender: UIButton) {
        
        dismiss(animated: false)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PVbarProgressView.progress = currentTime / maxTime
        
        tableView.lw_registerCellWithNib(
            identifier: String(describing: PracticeActivityInfoTableViewCell.self),
            bundle: nil)
        
        tableView.lw_registerCellWithNib(
            identifier: String(describing: SecondActivityInfoTableViewCell.self),
            bundle: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupGif()
        
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desVC = segue.destination
        let recordTime = lroundf(currentTime / 60)
        
        if let setupVC = desVC as? TrainSetupVC {
            setupVC.TSrecordTrainTime = recordTime
            
        } else if let setupVC = desVC as? StretchSetupVC {
            setupVC.SSrecordStretchTime = recordTime
        }
        
    }
    
    private func setupGif() {
        
        guard let workoutArray = PVworkoutArray else { return }
        let currentWorkout = workoutArray[PVworkoutIndex]
        PVworkoutImageView.animationImages = [
            UIImage(named: currentWorkout.images[0]),
            UIImage(named: currentWorkout.images[1])
            ] as? [UIImage]
        
        PVworkoutImageView.animationDuration = currentWorkout.perDuration
        PVworkoutImageView.startAnimating()
        
    }

}

extension PauseVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        guard let currentWorkout = PVworkoutArray?[workoutIndex] else { return 0 }
//
//        if currentWorkout.annotation != nil {
//            return 2
//        } else {
//            return 1
//        }
        
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
        
        guard let currentWorkout = PVworkoutArray?[PVworkoutIndex] else { return cell }
        
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
