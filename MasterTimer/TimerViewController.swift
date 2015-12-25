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
    @IBOutlet var levelLabel: UILabel!
    var skill = Skill(skillName: "Default")
    var nextLevel = Skill.SkillLevel.Beginner
    var nextLevelHour = 1.0
    var skillWhenStarted = Skill(skillName: "Default")
    var timer = NSTimer()
    var started = false
    
    override func viewDidLoad() {
        self.timeLabel.text = self.skill.timeSpent.secondsToHoursMinutesSecondsString() as String
        self.title = skill.name as String
        findNextLevel()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.updateSavedTime()
    }
    
    func findNextLevel() {
        self.levelLabel.text = self.skill.level.rawValue
        switch self.skill.timeSpent.secondsToHoursMinutesSeconds().hours {
        case 0..<1:
            if self.skill.timeSpent.secondsToHoursMinutesSeconds().minutes < 30 {
                self.nextLevel = Skill.SkillLevel.Beginner
                self.nextLevelHour = 0.5
            }else {
                self.nextLevel = Skill.SkillLevel.Novice
                self.nextLevelHour = 1
            }
        case 1..<3:
            self.nextLevel = Skill.SkillLevel.Mediocre
            self.nextLevelHour = 3
        case 3..<5:
            self.nextLevel = Skill.SkillLevel.Experienced
            self.nextLevelHour = 5
        case 5..<25:
            self.nextLevel = Skill.SkillLevel.Expert
            self.nextLevelHour = 25
        case 25..<50:
            self.nextLevel = Skill.SkillLevel.Master
            self.nextLevelHour = 50
        case 50..<100:
            self.nextLevel = Skill.SkillLevel.KnowNothing
            self.nextLevelHour = 100
        default:
            print("Error")
        }
    }
    
    func addSecond() {
        self.skill.timeSpent++
        self.timeLabel.text = self.skill.timeSpent.secondsToHoursMinutesSecondsString() as String
        if self.nextLevelHour == 0.5 {
            if self.skill.timeSpent.secondsToHoursMinutesSeconds().minutes > 30 {
                self.skill.level = self.nextLevel
                self.findNextLevel()
            }
        }else {
            if self.skill.timeSpent.secondsToHoursMinutesSeconds().hours > self.nextLevelHour {
                self.skill.level = self.nextLevel
                self.findNextLevel()
            }
        }
    }
    
    @IBAction func startButton(sender: AnyObject) {
        if !started {
            UIApplication.sharedApplication().idleTimerDisabled = true
            self.skillWhenStarted = self.skill
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("addSecond"), userInfo: nil, repeats: true)
            self.started = true
        }
    }
    
    @IBAction func stopButton(sender: AnyObject) {
        if started {
            print("When started: \(self.skillWhenStarted.timeSpent) and ended: \(self.skill.timeSpent)")
            self.updateSavedTime()
            self.timer.invalidate()
            self.started = false
        }
    }
    
    func updateSavedTime() {
        UIApplication.sharedApplication().idleTimerDisabled = false
        let defaults = NSUserDefaults.standardUserDefaults()
        if let curSkills = defaults.valueForKey("Skills")?.mutableCopy() as? NSMutableArray {
            print("curSkills:  \(curSkills)")
            for var i = 0; i < curSkills.count; i++ {
                let curSkill = curSkills.objectAtIndex(i).mutableCopy() as! NSMutableDictionary
                if (curSkill.objectForKey("Name") as! NSString) == self.skill.name {
                    print("HELLO \(self.skill.timeSpent)")
                    curSkill.removeObjectForKey("Time")
                    curSkill.setObject(self.skill.timeSpent, forKey: "Time")
                    curSkills.replaceObjectAtIndex(i, withObject: curSkill)
                }
            }
            defaults.setObject(curSkills as NSMutableArray, forKey: "Skills")
            defaults.synchronize()
        }else {
            print("ERROR")
        }
    }
}
