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
    
    func secondsToHoursMinutesSeconds () -> (Int, Int, Int) {
        return (Int(self) / 3600, (Int(self) % 3600) / 60, (Int(self) % 3600) % 60)
    }

}

class MainMenuViewController: UITableViewController {
    var skills: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        var x = NSTimeInterval()
        x = 3661
        println(x.secondsToHoursMinutesSeconds())
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SkillsCell") as! SkillCell
        cell.skillsNameLabel.text = ;
        cell.timeLabel.text = ;
    }
    
}
