//
//  ActivityItem.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/3.
//  Copyright © 2019 SSMNT. All rights reserved.
//

import UIKit

struct ActivityGroup {

    let firstLineTitle: String

    let secondLineTitle: String

    let caption: String

    let items: [ActivityItem]
}

protocol ActivityItem {

    var title: String { get }

}

enum ActivityType: String {
    
    case train
    
    case stretch
}

enum TrainItem: ActivityItem {

    case train0

    case train1

    case train2

    case train3

    case train4
    
    case train5

    var title: String {

        switch self {

        case .train0: return "全身运动"

        case .train1: return "胸臂训练"

        case .train2: return "侧腹训练"

        case .train3: return "腹部训练"

        case .train4: return "燃脂训练"
            
        case .train5: return "臀腿训练"

        }

    }
}

enum StretchItem: ActivityItem {

    case stretch0

    case stretch1

    case stretch2
    
    case stretch3

    var title: String {

        switch self {

        case .stretch0: return "起床伸展"

        case .stretch1: return "工作伸展"

        case .stretch2: return "运动后伸展"
            
        case .stretch3: return "睡前伸展"

        }

    }

}
