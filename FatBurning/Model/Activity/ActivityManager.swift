//
//  ActivityManager.swift
//   WorkOutLift
//
//  Created by Apple on 2019/4/2.
//  Copyright © 2019 SSMNT. All rights reserved.
//

class ActivityManager {

    let trainGroup = ActivityGroup(
        firstLineTitle: " 一点一滴训减重练肌肉 ",
        secondLineTitle: " 打造健康的易瘦体质 ",
        caption: "肌肉消耗的热量是脂肪的十倍。活化肌肉，就算只是走路时抬头挺胸、缩肚子也会带来效果！",
        items: [
            TrainItem.train0,
            TrainItem.train1,
            TrainItem.train2,
            TrainItem.train3,
            TrainItem.train4,
            TrainItem.train5
        ]
    )

    let stretchGroup = ActivityGroup(
        firstLineTitle: " 伸展活络身体 ",
        secondLineTitle: " 提升基础代谢三成 ",
        caption: "年过四十，适合用缓和运动提升代谢取代苦战式减重，善用零碎时间做做伸展运动吧！",
        items: [
            StretchItem.stretch0,
            StretchItem.stretch1,
            StretchItem.stretch2,
            StretchItem.stretch3
        ]
    )

    lazy var groups: [ActivityGroup] = [trainGroup, stretchGroup]
}
