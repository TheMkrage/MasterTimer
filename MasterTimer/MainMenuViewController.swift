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
    
    func secondsToHoursMinutesSeconds () -> (hours: Int, minutes: Int, seconds: Int) {
        return (Int(self) / 3600, (Int(self) % 3600) / 60, (Int(self) % 3600) % 60)
    }

}

class MainMenuViewController: UITableViewController {
    var skills: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {

    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    func loadSkills() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let curSkills = defaults.valueForKey("Skills") as? NSArray {
            self.skills.addObjectsFromArray(curSkills as [AnyObject])
        }
        if self.skills.count > 0 {
            self.tableView.reloadData();
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
        cell.skillsNameLabel.text = curSkill.name as String;
        var tuple = curSkill.timeSpent.secondsToHoursMinutesSeconds()
        cell.timeLabel.text = "\(tuple.hours):\(tuple.minutes):\(tuple.seconds)";
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var vc = TimerViewController()
        
    }
    
}
