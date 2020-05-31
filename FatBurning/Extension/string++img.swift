//
//  string++img.swift
//  FatBurning
//
//  Created by Apple on 2020/1/3.
//  Copyright © 2020 Shenzhen Starry Mood. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func toImg() -> UIImage? {
        return UIImage(named: self)
    }
}

extension Array where Array.Element == String {
    func toImgArray() -> [UIImage]? {
        var imgs = [UIImage]()
        imgs = self.map({ $0.toImg()! })
        
        return imgs
    }
}
