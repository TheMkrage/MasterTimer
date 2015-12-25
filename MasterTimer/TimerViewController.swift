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
    var skillWhenStarted = Skill(skillName: "Default")
    var timer = NSTimer()
    
    override func viewDidLoad() {
        self.timeLabel.text = self.skill.timeSpent.secondsToHoursMinutesSecondsString() as String
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.updateSavedTime()
    }
    
    func addSecond() {
        self.skill.timeSpent++
        self.timeLabel.text = self.skill.timeSpent.secondsToHoursMinutesSecondsString() as String
    }
    
    @IBAction func startButton(sender: AnyObject) {
        self.skillWhenStarted = self.skill
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("addSecond"), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopButton(sender: AnyObject) {
        print("When started: \(self.skillWhenStarted.timeSpent) and ended: \(self.skill.timeSpent)")
        self.updateSavedTime()
        self.timer.invalidate()
    }
    
    func updateSavedTime() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let curSkills = defaults.valueForKey("Skills") as? NSMutableArray {
            print("curSkills:  \(curSkills)")
            for var i = 0; i < curSkills.count; i++ {
                let curSkill = curSkills.objectAtIndex(i) as! NSMutableDictionary
                if (curSkill.objectForKey("Name") as! NSString) == self.skill.name {
                    print("HELLO \(self.skill.timeSpent)")
                    curSkill.setObject(self.skill.timeSpent, forKey: "Time")
                }
            }
            defaults.setObject(curSkills as NSMutableArray, forKey: "Skills")
            defaults.synchronize()
        }else {
            print("ERROR")
        }
    }
}
