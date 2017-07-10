//
//  XDEyeView.swift
//  MinionsDemo
//
//  Created by sephilex on 2017/7/10.
//  Copyright © 2017年 sephilex. All rights reserved.
//

import UIKit

class XDEyeView: UIImageView {

    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return UIDynamicItemCollisionBoundsType(rawValue: 1)!;
    }

}
