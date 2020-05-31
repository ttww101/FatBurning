//
//  KnowledgeVC.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/6.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit

class KnowledgeVC: LWBaseVC, UITableViewDelegate {

    @IBOutlet weak var KVfoodBtn: UIButton!

    @IBOutlet weak var KVworkoutBtn: UIButton!

    @IBOutlet weak var KVliverBtn: UIButton!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var KVcategoryBtns: [UIButton]!
    
    @IBAction func categoryBtnPressed(_ sender: UIButton) {
        
        if sender.isSelected == true {
            
            for btn in KVcategoryBtns {
                
                btn.isSelected = false
                
            }
            
        } else {
            
            for btn in KVcategoryBtns {
                
                btn.isSelected = false
                
            }
            
            sender.isSelected = true
            
        }
        
        setupCategoryBtnView(
            foodIsSelected: KVfoodBtn.isSelected,
            workoutIsSelected: KVworkoutBtn.isSelected,
            liverIsSelected: KVliverBtn.isSelected
        )
        
        selectListWithIndex(sender)
        
    }
    
    private func selectListWithIndex(_ sender: UIButton) {
        
        selectedIndex = sender.tag
        
        if KVfoodBtn.isSelected == false && KVworkoutBtn.isSelected == false && KVliverBtn.isSelected == false {
            selectedIndex = 0
            KVfoodBtn.backgroundColor = .G1
            KVworkoutBtn.backgroundColor = .Orange
            KVliverBtn.backgroundColor = .Yellow
        }
        
    }
    
    private func setupCategoryBtnView(foodIsSelected: Bool, workoutIsSelected: Bool, liverIsSelected: Bool) {
        
        let foodColor = foodIsSelected ? UIColor.G1 : UIColor.B1
        
        let workoutColor = workoutIsSelected ? UIColor.Orange : UIColor.B1
        
        let liverColor = liverIsSelected ? UIColor.Yellow : UIColor.B1
    
        KVfoodBtn.backgroundColor = foodColor
        
        KVworkoutBtn.backgroundColor = workoutColor
        
        KVliverBtn.backgroundColor = liverColor
        
    }
    
    var listArray: [[Knowledge]] {
        return [knowledgeList, foodList, workoutList, fattyLiverList]
    }
    
    var list: [Knowledge] {
        return listArray[selectedIndex]
    }
    
    var selectedIndex = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    let knowledgeManager = KnowledgeManager()
    
    var knowledgeList = [Knowledge]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selectedKnowledge: Knowledge?
    
    var foodList = [Knowledge]()
    
    var workoutList = [Knowledge]()
    
    var fattyLiverList = [Knowledge]()
    
    override func getData() {
        
        knowledgeManager.getKnowledge { (knowledgeList, _ ) in
            
            guard let knowledgeList = knowledgeList else { return }
            
            self.knowledgeList = knowledgeList
            
            self.filterList()
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true

    }
    
    private func filterList() {
        
        foodList = knowledgeList.filter({ return $0.category == "food" })
        
        workoutList = knowledgeList.filter({ return $0.category == "workout" })
        
        fattyLiverList = knowledgeList.filter({ return $0.category == "fattyLiver" })
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 134
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        let storyboard = UIStoryboard(name: "Knowledge", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "knowledgeDetail") as? DetailKnowledgeVC else{
            return
        }
//        let controller = UIViewController()
//        controller.view.backgroundColor = .red
        controller.knowledge = list[indexPath.row]
//        controller.modalTransitionStyle = .crossDissolve
        
        controller.modalPresentationStyle = .overFullScreen
    
//        self.present(controller, animated: true, completion: nil)
        DispatchQueue.main.async {
            self.present(controller, animated: true) {
                print("finish")
            }
//        CFRunLoopWakeUp(CFRunLoopGetCurrent())
        }
        
    }
    
    

}

extension KnowledgeVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: KnowledgeTableViewCell.self),
            for: indexPath
        )
        
        guard let knowledgeCell = cell as? KnowledgeTableViewCell else { return cell }
        
        let listSelected = list[indexPath.row]
        
        knowledgeCell.layoutView(category: listSelected.category, title: listSelected.title)
        
        knowledgeCell.selectionStyle = .none
        
        return knowledgeCell
    }

}
