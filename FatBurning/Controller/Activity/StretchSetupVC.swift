//
//  StretchSetupVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/6.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit
//import Firebase
import SCLAlertView

class StretchSetupVC: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var stretchImageView: UIImageView!
    
    @IBOutlet weak var SSdescriptionLabel: UILabel!
    
    @IBOutlet weak var SSworkoutTimeLabel: UILabel!
    
    @IBOutlet weak var SSstartBtn: UIButton!
    
    @IBAction func dismissBtnPressed(_ sender: UIBarButtonItem) {

        dismiss(animated: true)

    }

    @IBOutlet weak var navBarItem: UINavigationItem!

    @IBOutlet weak var tableView: UITableView!
    
    let workoutElementManager = WorkoutElementManager()
    
    var workoutElement: WorkoutElement? {
        didSet {
            tableView.isHidden = false
            
            SSstartBtn.isHidden = false
            
            tableView.reloadData()
            
            setupView()
        }
    }
    
    var SSid: String?
    
    var SSrecordStretchTime: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.lw_registerCellWithNib(
            identifier: String(describing: ActivitySetupTableViewCell.self),
            bundle: nil)
        
        guard let SSid = SSid else { return }
        
        if workoutElement == nil {
            tableView.isHidden = true
        }
        
        SSstartBtn.isHidden = true
        
        workoutElementManager.getWorkoutElement(id: SSid) { (workoutElement, error) in
            if let error = error {
                print(error)
            } else {
                self.workoutElement = workoutElement
            }
        }
        

    }
    
    private func setupView() {
        
        guard let workoutElement = workoutElement else { return }
        
        navBarItem.title = workoutElement.title
        
        stretchImageView.image = UIImage(named: workoutElement.icon)
        
        SSdescriptionLabel.text = workoutElement.description
        
        guard let time = workoutElement.time else { return }
        
        SSworkoutTimeLabel.text = "\(time)分钟"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desVC = segue.destination as? StretchNavVC {
            
            guard let workoutElement = workoutElement else { return }
            
            desVC.workoutArray = workoutElement.workoutSet
            desVC.workoutMinutes = Float(workoutElement.time!)
            desVC.navTitle = workoutElement.title
        }
        
        if let practiceVC = segue.destination as? PracticeVC {
            practiceVC.PVworkoutArray = workoutElement?.workoutSet
        }
    }
    
    @IBAction func unwindtoSetup(segue: UIStoryboardSegue) {
        
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        
//        guard let user = Auth.auth().currentUser else { return }
        
        guard let workoutElement = workoutElement else { return }
        
        guard let recordStretchTime = SSrecordStretchTime else { return }
        
        if recordStretchTime > 0 {
            
            LeanCloudService.shared.saveActivity("stretch", workoutElement.title, recordStretchTime) { (completion, error) in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Train Workout Time Document succesfully updated")
                }
            }
//            AppDelegate.db.collection("users").document(user.uid).collection("workout").addDocument(
//                data: [
//                    "activity_type": "stretch",
//                    "title": workoutElement.title,
//                    "workout_time": SSrecordStretchTime,
//                    "created_time": time
//            ]) { (error) in
//                if let error = error {
//                    print("Error updating document: \(error)")
//                } else {
//                    print("Stretch Workout Time Document succesfully updated")
//                }
//            }
            
            SCLAlertView().showSuccess("运动登录", subTitle: "太好了，完成 \(recordStretchTime) 分钟运动！")
        }
        
    }
}

extension StretchSetupVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workoutElement?.workoutSet.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivitySetupTableViewCell", for: indexPath)
        
        guard let setupCell = cell as? ActivitySetupTableViewCell else { return cell }
        
        guard let workoutSet = workoutElement?.workoutSet[indexPath.row] else { return cell }
        
        setupCell.layoutView(image: workoutSet.thumbnail, title: workoutSet.title)

        return setupCell

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

}
