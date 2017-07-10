//
//  ViewController.swift
//  MinionsDemo
//
//  Created by sephilex on 2017/7/10.
//  Copyright © 2017年 sephilex. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var leftEye: XDEyeView!
    @IBOutlet weak var rightEye: XDEyeView!
    
    var animator : UIDynamicAnimator?
    var gravity  : UIGravityBehavior!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 让两只眼睛变圆
        self.leftEye.layer.masksToBounds = true;
        self.leftEye.layer.cornerRadius = 10;
        self.leftEye.contentMode = UIViewContentMode.scaleAspectFit
        
        self.rightEye.layer.masksToBounds = true;
        self.rightEye.layer.cornerRadius = 10;
        self.rightEye.contentMode = UIViewContentMode.scaleAspectFit
        // 开始表演
        self.phsicalEngine()
        self.gravitySence()
    }
    func phsicalEngine() {
        let gravity = UIGravityBehavior.init()
        gravity.magnitude = 1
        gravity.addItem(self.leftEye)
        gravity.addItem(self.rightEye)
        self.gravity = gravity
        self.animator?.addBehavior(gravity)
        //设置摩擦力
        let collision = UICollisionBehavior.init()
        // 设置左右两眼睛可移动的边界
        let pathL = UIBezierPath.init(ovalIn: CGRect(x: 138, y: 287, width: 45, height: 42))
        let pathR = UIBezierPath.init(ovalIn: CGRect(x: 193, y: 287, width: 45, height: 42))

        collision.addBoundary(withIdentifier: "circle" as NSCopying, for: pathL)
        collision.addBoundary(withIdentifier: "circle" as NSCopying, for: pathR)
        
        collision.addItem(self.leftEye)
        collision.addItem(self.rightEye)
        let item = UIDynamicItemBehavior.init(items: [self.leftEye, self.rightEye])
        //摩擦力
        item.friction = 100;
        self.animator = UIDynamicAnimator.init(referenceView: self.view)
        self.animator?.addBehavior(item)
        // 3.开始仿真
        self.animator?.addBehavior(gravity)
        self.animator?.addBehavior(collision)
    }
    func gravitySence() {
        let motionManager = CMMotionManager.init()
        // 刷新频率1000次每秒
        motionManager.accelerometerUpdateInterval = 0.015
        // 刷新后更新重力数据
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (CMAccelerometerData, Error) in
            let lastestAccel = motionManager.accelerometerData;
            let accelX = lastestAccel?.acceleration.x
            let accelY = lastestAccel?.acceleration.y
            self.gravity.gravityDirection = CGVector.init(dx: accelX!, dy: -accelY!)
            
        }
    }
}

