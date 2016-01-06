//
//  ViewController.swift
//  KaiShiShangke
//
//  Created by 文凡胡 on 1/6/16.
//  Copyright © 2016 Th. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var finishClassLable: UILabel!
    let KEY_BEGIN_TIME = "key_begin_time"
    var notifycation:UILocalNotification!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        notifycation = UILocalNotification()
        updateFinishClassUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func begin(sender: AnyObject) {
        if beginButton.titleLabel?.text == "开始学习" {
            beginButton.titleLabel?.text = "重新开始"
            beginButton.setTitle("重新开始", forState: .Normal)
        }
        
        let current = NSDate().timeIntervalSince1970
        print(current)
        let timeInInt: Int = Int(current)
        
        NSUserDefaults.standardUserDefaults().setInteger(timeInInt, forKey: KEY_BEGIN_TIME)
        
        updateFinishClassUI()
        
//        notifycation.fireDate = NSDate(timeIntervalSince1970: (current + 45 * 60 * 1000))
//        notifycation.fireDate = NSDate().dateByAddingTimeInterval(1)
        notifycation.fireDate = NSDate(timeIntervalSinceNow: 20 * 60)
//        notifycation.repeatInterval = .Weekday
        notifycation.timeZone = NSTimeZone.defaultTimeZone()
        notifycation.alertBody = "下课啦"
        notifycation.alertAction = "alertAction"
        notifycation.hasAction = false
        notifycation.soundName = UILocalNotificationDefaultSoundName
        notifycation.applicationIconBadgeNumber = -1
        
        UIApplication.sharedApplication().cancelLocalNotification(notifycation)
        UIApplication.sharedApplication().scheduleLocalNotification(notifycation)
    }
    
    func updateFinishClassUI() {
        let timeInInt = NSUserDefaults.standardUserDefaults().integerForKey(KEY_BEGIN_TIME)
        
        let currentTime = NSDate().timeIntervalSince1970
        let currentTimeInInt = Int(currentTime)
        
        let endTimeInInt = timeInInt + 45 * 60;
        
        if (endTimeInInt < currentTimeInInt) {
            finishClassLable.text = "已下课"
        } else {
            let leftTime = endTimeInInt - currentTimeInInt
            finishClassLable.text = "离下课还有\(leftTime / 60)分钟"
        }
    }
    
}

