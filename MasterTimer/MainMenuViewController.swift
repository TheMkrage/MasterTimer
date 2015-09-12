//
//  MainMenuViewController.swift
//  MasterTimer
//
//  Created by Matthew Krager on 9/7/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

import UIKit

extension Int {
    func format(f: String) -> Int{
        return NSString(format: "%\(f)d", self).integerValue
    }
}

extension Double {
    func format(f: String) -> Double {
        return NSString(format: "%\(f as String)f", self).doubleValue
    }
}

extension NSTimeInterval {
    
    // returns a tuple with hours, minutes, and seconds
    func secondsToHoursMinutesSeconds() -> (hours: Int, minutes: Int, seconds: Int) {
        return (Int(self) / 3600, (Int(self) % 3600) / 60, (Int(self) % 3600) % 60)
    }
    
    // Returns in hhh:mm:ss format
    func secondsToHoursMinutesSecondsString() -> NSString {
        var tuple = self.secondsToHoursMinutesSeconds()
        var runningString = ""
        // Go through each part of tuple and add 0's where needed
        if tuple.hours < 10 {
            runningString += "00\(tuple.hours):"
        }else if tuple.hours < 100 {
            runningString += "0\(tuple.hours):"
        }else {
            runningString += "\(tuple.hours):"
        }
        if tuple.minutes < 10 {
            runningString += "0\(tuple.minutes):"
        }else {
            runningString += "\(tuple.minutes):"
        }
        if tuple.seconds < 10 {
            runningString += "0\(tuple.seconds)"
        }else {
            runningString += "\(tuple.seconds)"
        }
        return runningString
    }

}

class MainMenuViewController: UITableViewController {
    var skills: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        self.viewWillAppear(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        println("HELO")
        // refresh each time
        self.skills = NSMutableArray()
        self.loadSkills()
        self.tableView.reloadData()
    }
    
    func loadSkills() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let curSkills = defaults.valueForKey("Skills") as? NSArray {
            for skill in curSkills {
                var s:Skill = Skill(skillName: skill.objectForKey("Name") as! String, timeInDouble: skill.objectForKey("Time") as! Double)
                self.skills.addObject(s)
            }
        }else { // initial launch, make array here
            let defaults = NSUserDefaults.standardUserDefaults()
            var newSkills: NSMutableArray = NSMutableArray()
            defaults.setObject(newSkills as NSArray, forKey: "Skills")
            defaults.synchronize()
        }
        if self.skills.count > 0 {
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.skills.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SkillCell") as! SkillCell
        var curSkill = self.skills.objectAtIndex(indexPath.row) as! Skill
        cell.skillsNameLabel.text = curSkill.name as String
        cell.timeLabel.text = curSkill.timeSpent.secondsToHoursMinutesSecondsString() as String
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var vc = self.storyboard?.instantiateViewControllerWithIdentifier("Timer") as! TimerViewController
        vc.skill = self.skills.objectAtIndex(indexPath.row) as! Skill
        self.showViewController(vc, sender: self)
    }
    
}
