//
//  TimerViewController.swift
//  MasterTimer
//
//  Created by Matthew Krager on 9/11/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    @IBOutlet var timeLabel: UILabel!
    var skill = Skill(skillName: "Default")
    var timer = NSTimer()
    
    override func viewDidLoad() {
        self.timeLabel.text = self.skill.timeSpent.secondsToHoursMinutesSecondsString() as String
    }
    
    func addSecond() {
        self.skill.timeSpent++
        self.timeLabel.text = self.skill.timeSpent.secondsToHoursMinutesSecondsString() as String
    }
    
    @IBAction func startButton(sender: AnyObject) {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("addSecond"), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopButton(sender: AnyObject) {
        self.timer.invalidate()
        self.updateSavedTime()
    }
    
    func updateSavedTime() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let curSkills = defaults.valueForKey("Skills") as? NSArray {
            for var i = 0; i < curSkills.count; i++ {
                var curSkill = curSkills.objectAtIndex(i) as! NSMutableDictionary
                if (curSkill.objectForKey("Name") as! NSString) == self.skill.name {
                    curSkill.setObject(self.skill.timeSpent, forKey: "Time")
                }
            }
            defaults.setObject(curSkills, forKey: "Skills")
            defaults.synchronize()
        }else {
            println("ERROR")
        }

    }
}
